#!/usr/bin/python

# controller data refresher for Input
# @offalynne for Input: https://github.com/JujuAdams/Input, 2021

import re
import os
import sys
import urllib
import shutil

# sources and parsing expressions per datafile
marker_id = "$$$"
DATA_SOURCES = {

    "TYPES": {
        "datafile": "controllertypes.csv",
        "sources": {

            "SDL2 typelist": {

                "source": "https://raw.githubusercontent.com/libsdl-org/SDL/master/src/joystick/controller_type.h",
                "license": "https://raw.githubusercontent.com/libsdl-org/SDL/main/LICENSE.txt",
                "trim before": "k_eControllerType_LastController",
                "trim after": "k_eControllerType_UnknownSteamController",
                "match category": "(?<=k_eControllerType_)(.*)(?= = )",
                "match id": "MAKE_CONTROLLER_ID\((.*),(.*)\),k_eControllerType_" + marker_id + ",",
            },

            "Community SDL2 typelist": {

                "source": "https://gist.github.com/offalynne/1cf66d663a26c054f46c26c826666bf9/raw",
                "match category": "(?<=.{10})(.{1,})(?= //.*)",
                "match id": "(.{4}),(.{4})," + marker_id
            }
        }
    },

    "BLACKLIST": {
        "datafile": "controllerblacklist.csv",
        "sources": { 

            "udev Blacklist": {

                "source": "https://raw.githubusercontent.com/denilsonsa/udev-joystick-blacklist/master/generate_rules.py",
                "header": "linux,vid+pid",
                "trim before": "def write_mode",
                "trim after": "DEVICES = [",
                "match id": "'(.*?)','(.*?)'"
            },

            "Chromium blocklist (vid+pid)": {

                "source": "https://raw.githubusercontent.com/chromium/chromium/master/device/gamepad/gamepad_blocklist.cc",
                "license": "https://raw.githubusercontent.com/chromium/chromium/master/LICENSE",
                "header": "linux,vid+pid",
                "trim before": "constexpr uint16_t kBlockedVendors[]",
                "trim after": "namespace {",
                "match replace": "constexpr uint16_t (.*) = (.*);",
                "match id": "{0x(.*),0x(.*)}"

            },

            "Chromium blocklist (vid)": {

                "source": "https://raw.githubusercontent.com/chromium/chromium/master/device/gamepad/gamepad_blocklist.cc",
                "header": "linux,vid",
                "trim before": "}  // namespace",
                "trim after": "namespace {",
                "match replace": "constexpr uint16_t k(.*) = (.*);",
                "match id": "(/s)*k(.*),"

            },

            "Input blocklist": {

                "source": "https://gist.githubusercontent.com/offalynne/07f78774e3d9ff00fc79200951ac1883/raw",
                "match category": "(?<=\,)(.*)(?=\s//)",
                "match id": "(.*)(?:," + marker_id + ")"

            }
        }
    },

    "MAPS": {
        "datafile": "sdl2.txt",
        "sources": { 

            "SDL2 Community map db": {

                "source":  "https://raw.githubusercontent.com/gabomdq/SDL_GameControllerDB/master/gamecontrollerdb.txt"

            }
        }
    }
}

# handle folder
if os.path.isdir("datafiles"):
    shutil.rmtree("datafiles")
os.mkdir("datafiles")
working_folder = "datafiles"
license_path = working_folder + "/licenses.txt"
license_handle = open(license_path, "a")

# consume data
for file in DATA_SOURCES:

    data_index = DATA_SOURCES.get(file)
    filename = data_index.get("datafile")
    sources = list(data_index.get("sources"))

    working_path = working_folder + "/" + filename
    working_handle = open(working_path, "a")

    print "Refreshing " + filename

    # index sources
    for source in sources:
        source_index = data_index.get("sources").get(source)

        print "\tLoading " + source

        # load source content
        source_content = None
        try: 
            source_content = urllib.urlopen(source_index.get("source")).read()
            if source_content.lower().find("doctype") != -1 or source_content == "404: Not Found":
                raise RuntimeError('Invalid source file')
        except:
            exit('Failed to fetch source for ' + source)

        source_content = urllib.urlopen(source_index.get("source")).read()

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
                print "\tLoading " + source + " license"
                license_content = urllib.urlopen(license).read()
                if license_content.lower().find("doctype") != -1 or license_content == "404: Not Found":
                    raise RuntimeError('Invalid license file')
            except: 
                exit('Failed to fetch license for ' + source)

            # render license
            license_handle.write(filename + " includes data sourced from " + source + ".\n")
            license_handle.write(license_content + "\n")
