#!/usr/bin/python
# -*- coding: UTF-8 -*-

# controller data refresher for Input
# @offalynne for Input: https://github.com/JujuAdams/Input, 2021

import sys
if sys.version_info[0] != 3:
    exit('This script requires Python 3.')

import re
import os
import urllib.request
import shutil
import datetime

# sources and parsing expressions per datafile
marker_id = "$$$"
github_urlpath = "https://raw.githubusercontent.com/"
DATA_SOURCES = {

    "TYPES": {
        "datafile": "controllertypes.csv",
        "sources": {
            "SDL2 typelist": {
                "source": github_urlpath + "libsdl-org/SDL/master/src/joystick/controller_list.h",
                "license": github_urlpath + "libsdl-org/SDL/main/LICENSE.txt",
                "match category": "(?<=k_eControllerType_)(.*)(?=\,\ N)",
                "match id": "MAKE_CONTROLLER_ID\((.*),(.*)\),k_eControllerType_" + marker_id + ","
            },
            "Community SDL2 typelist": {
                "source": github_urlpath + "offalynne/Input/community-data/community_gamepad_type.txt",
                "match category": "(?<=.{10})(.{1,})(?= //.*)",
                "match id": "(.{4}),(.{4})," + marker_id
            }
        }
    },

    "BLACKLIST": {
        "datafile": "controllerblacklist.csv",
        "sources": { 
            "udev Blacklist": {
                "source": github_urlpath + "denilsonsa/udev-joystick-blacklist/master/generate_rules.py",
                "header": "linux,vid+pid",
                "trim before": "def write_mode",
                "trim after": "DEVICES = [",
                "match id": "'(.*?)','(.*?)'"
            },
            "Chromium blocklist (vid+pid)": {
                "source": github_urlpath + "chromium/chromium/master/device/gamepad/gamepad_blocklist.cc",
                "license": github_urlpath + "chromium/chromium/master/LICENSE",
                "header": "linux,vid+pid",
                "trim before": "constexpr uint16_t kBlockedVendors[]",
                "trim after": "namespace {",
                "match replace": "constexpr uint16_t (.*) = (.*);",
                "match id": "{0x(.*),0x(.*)}"
            },
            "Input blocklist": {
                "source": github_urlpath + "JujuAdams/Input/community-data/community_blocklist.txt",
                "match category": "(?<=\,)(.*)(?=\s//)",
                "match id": "(.*)(?:," + marker_id + ")"
            }
        }
    },

    "MAPS": {
        "datafile": "sdl2.txt",
        "sources": {
            "SDL2 Community map db": {
                "source":  github_urlpath + "mdqinc/SDL_GameControllerDB/master/gamecontrollerdb.txt",
                "trim after": "# Game Controller DB for SDL in 2.0.16 format\n",
                "trim before": "\n# iOS"
            }
        }
    },

    "LABELS": {
        "deprecated": True,
        "datafile": "buttonlabels.csv",
        "sources": {
            "Gamepad button labels": {
                "source":  github_urlpath + "JujuAdams/Input/community-data/button_labels.csv"
            }
        }
    },

    "COLORS": {
        "deprecated": True,
        "datafile": "buttoncolors.csv",
        "sources": { 
            "Gamepad button colors": {
                "source":  github_urlpath + "JujuAdams/Input/community-data/button_colors.csv"
            }
        }
    }
}

# handle folders
print("Setting up directories")
if os.path.isdir("datafiles.bak"):
    shutil.rmtree("datafiles.bak")
if os.path.isdir("datafiles"):
    shutil.copytree("datafiles", "datafiles.bak")
else:
    os.mkdir("datafiles")
working_folder = "datafiles"
license_path = working_folder + "/input_license.txt"
if os.path.exists(license_path):
        os.remove(license_path)
shutil.copy("LICENSE", license_path)
license_handle = open(license_path, "a")

# consume data
for file in DATA_SOURCES:

    data_index = DATA_SOURCES.get(file)
    filename = data_index.get("datafile")
    sources = list(data_index.get("sources"))

    working_path = working_folder + "/" + filename
    if os.path.exists(working_path):
        os.remove(working_path)
    working_handle = open(working_path, "a")

    print("Refreshing " + filename)

    # index sources
    for source in sources:

        # ignore deprecated sources
        if data_index.get("deprecated") and not os.path.exists("datafiles.bak/" + filename):
            print("\tSkipping " + source + "…")
            working_handle.close()
            os.remove(working_path)
            continue

        # log source
        source_index = data_index.get("sources").get(source)
        print("\tLoading " + source + "…")

        # load source content
        source_content = None
        try: 
            source_content = urllib.request.urlopen(source_index.get("source")).read().decode('utf-8')
            if source_content.lower().find("doctype") != -1 or source_content == "404: Not Found":
                raise RuntimeError('Invalid source file')
        except Exception as e:
            print(e)
            exit('Failed to fetch source for ' + source)

        source_content = urllib.request.urlopen(source_index.get("source")).read().decode('utf-8')

        # parse categories
        category = source_content
        seek_after = source_index.get("trim after")
        seek_before = source_index.get("trim before")

        if seek_after != None and seek_before != None:
            seek_start = source_content.index(seek_after) + len(seek_after)
            seek_end = source_content.index(seek_before, seek_start)
            category = source_content[seek_start:seek_end]

        # parse ids
        regex_categories = source_index.get("match category")

        # index categories
        if regex_categories != None:
            list_categories = list(dict.fromkeys(re.findall(regex_categories, category)))
        else:
            source_content = category
            list_categories = [""]

        # make substitutions
        regex_subs = source_index.get("match replace")
        if regex_subs != None:
            list_subs = list(dict.fromkeys(re.findall(regex_subs, category)))
            for sub in range(len(list_subs)):
                source_content = source_content.replace(list_subs[sub][0], list_subs[sub][1])

        # clean source
        if source_index.get("match id") != None:
            source_content = source_content.replace(" ", "")

        # index ids
        file_content = ""
        if source_index.get("match id") == None:
            file_content = source_content
        else:
            for category in range(len(list_categories)):

                # parse list id
                regex_ids = source_index.get("match id")
                if source_index.get("match category") != None:
                    regex_ids = regex_ids.replace(marker_id, list_categories[category].replace("+", "\+").replace(" ", ""))
                
                list_ids = re.findall(regex_ids, source_content)

                # short circuit category if it contains no ids
                if len(list_ids) == 0:
                    continue

                # log category
                file_line = (list_categories[category])
                if source_index.get("header") != None:
                    file_line = source_index.get("header")

                # build id list
                for id in range(len(list_ids)):

                    # delimit ids
                    file_line += ","

                    # format vendor and product id
                    if len(list_ids[id]) == 2:
                        for i in range(2):

                            # sanitize id, swap endianness
                            i_value = list_ids[id][i]
                            if i_value != "":
                                i_value = i_value.lower().replace(" ","").replace("\t","").replace("0x","").zfill(4)
                                i_value = i_value[2] + i_value[3] + i_value[0] + i_value[1]
                            
                            # log id
                            file_line += i_value
                    else:
                        file_line += list_ids[id]

                # compose line
                file_content += file_line + "\n"

        # render file content
        working_handle.write(file_content)

        # load license
        license = source_index.get("license")
        license_content = None
        if license != None:
            try: 
                print("\tLoading " + source + " license" + "…")
                license_content = urllib.request.urlopen(license).read().decode('utf-8')
                if license_content.lower().find("doctype") != -1 or license_content == "404: Not Found":
                    raise RuntimeError('Invalid license file')
            except: 
                exit('Failed to fetch license for ' + source)

            # clean license
            license_content = license_content.replace("// ", "").replace("//", "");

            # render license
            license_handle.write("\n"*3)
            license_handle.write("Datafile " + filename + " includes data sourced from " + source + "\n")
            license_handle.write(license_content)

print("Removing backup")
if os.path.isdir("datafiles.bak"):
    shutil.rmtree("datafiles.bak")

print("Done")
