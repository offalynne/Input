#!/usr/bin/python
# -*- coding: UTF-8 -*-

# Gamepad data refresher for Input
# https://github.com/offalynne/Input, 2025

import sys
if sys.version_info[0] != 3:
    exit('This script requires Python 3.')

import re
import os
import urllib.request
import shutil

# sources and parsing expressions per destination
marker_id = "$$$"
github_urlpath = "https://raw.githubusercontent.com/"
DATA_SOURCES = {
    "TYPES": {
        "destination": "__InputCreateTypeLookup.gml",
        "sources": {
            "SDL2 typelist": {
                "source": github_urlpath + "libsdl-org/SDL/master/src/joystick/controller_list.h",
                "match category": "(?<=k_eControllerType_)(.*)(?=\,\ N)",
                "match id": "MAKE_CONTROLLER_ID\((.*),(.*)\),k_eControllerType_" + marker_id + ",",
            },
            "Community SDL2 typelist": {
                "source": github_urlpath + "offalynne/Input/community-data/community_gamepad_type.txt",
                "match category": "(?<=.{10})(.{1,})(?= //.*)",
                "match id": "(.{4}),(.{4})," + marker_id,
            }
        },
        "prefix": "// Feather disable all\n\nfunction __InputCreateTypeLookup()\n{\n    static _struct = (function()\n    {\n        var _struct = {};\n",
        "suffix": "\n        return _struct;\n    })();\n    \n    return _struct;\n}\n"
    }
}

# gamepad type mapping
GAMEPAD_TYPE_MAPPING = {
    "INPUT_GAMEPAD_TYPE_PS4": ["PS4Controller", "XInputPS4Controller", "CommunityPS4", "PS3Controller", "CommunityPSX"],
    "INPUT_GAMEPAD_TYPE_PS5": ["PS5Controller", "CommunityPS5"],
    "INPUT_GAMEPAD_TYPE_JOYCON_LEFT": ["SwitchJoyConLeft", "SwitchJoyConSingle", "HIDJoyConLeft"],
    "INPUT_GAMEPAD_TYPE_JOYCON_RIGHT": ["SwitchJoyConRight", "HIDJoyConRight"],
    "INPUT_GAMEPAD_TYPE_SWITCH": [ "SwitchHandheld", "SwitchJoyConPair", "SwitchProController", "XInputSwitchController", "SwitchInputOnlyController", "CommunityLikeSwitch", "Community8BitDo", "HIDWiiClassic", "CommunitySNES", "CommunitySuperFamicom"],

    # # omit xbox, we assume this type by default
    # "INPUT_GAMEPAD_TYPE_XBOX": ["XBoxOneController", "CommunityXBoxOne", "SteamControllerNeptune", "CommunitySteamDeck", "CommunityLuna", "CommunityStadia", "AppleController", "XBox360Controller", "CommunityXBox360", "CommunityDreamcast", "SteamController", "MobileTouch", "CommunityLikeXBox"]
}

# fetch gamecontrollerdb.txt
script_dir = os.path.dirname(os.path.realpath(__file__))
datafiles_dir = os.path.join(script_dir, "datafiles")
os.makedirs(datafiles_dir, exist_ok=True)

gamecontrollerdb_path = os.path.join(datafiles_dir, "gamecontrollerdb.txt")
gamecontrollerdb_url = "https://raw.githubusercontent.com/mdqinc/SDL_GameControllerDB/refs/heads/master/gamecontrollerdb.txt"

try:
    print("Refreshing gamecontrollerdb.txt…")
    with urllib.request.urlopen(gamecontrollerdb_url) as response, open(gamecontrollerdb_path, 'wb') as out_file:
        shutil.copyfileobj(response, out_file)
    print("\tSaved to " + gamecontrollerdb_path)
except Exception as e:
    print(e)
    exit('Failed to fetch gamecontrollerdb.txt')

# consume data
for file in DATA_SOURCES:

    data_index = DATA_SOURCES.get(file)
    filename = data_index.get("destination")
    sources = list(data_index.get("sources"))

    working_path = os.path.join(script_dir, "scripts/__InputCreateTypeLookup", filename)
    if os.path.exists(working_path):
        os.remove(working_path)
    working_handle = open(working_path, "w")

    print("Refreshing " + filename)
    working_handle.write(data_index.get("prefix"))

    # index sources
    for source in sources:
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

                # build id list
                for id in range(len(list_ids)):

                    file_line = ""

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

                    # raw type to simple
                    raw_category = list_categories[category]
                    for simple_type, types in GAMEPAD_TYPE_MAPPING.items():
                            if raw_category in types:
                                file_content += " "*8 + "_struct[$ \"" + file_line + "\"] = " + simple_type + ";\n"

        # render file content
        working_handle.write(file_content)
    working_handle.write(data_index.get("suffix"))

print("Done")
