# gamepad device type list renderer
# @offalynne for https://github.com/JujuAdams/Input, 2021

# get remote
try: from requests import get
except: exit('Failed to import module `requests`. Install with eg. `pip install requests`.')

# sdl source
source_url_sdl = "https://raw.githubusercontent.com/libsdl-org/SDL/master/src/joystick/controller_type.h"
try: source_sdl = get(source_url_sdl).text
except: exit('Failed to fetch SDL source file.')

# community source
source_url_community = "https://gist.github.com/offalynne/1cf66d663a26c054f46c26c826666bf9/raw"
try: source_community = get(source_url_community).text
except: exit('Failed to fetch Community source file.')

# catch misdirect
if source_sdl.lower().find("doctype") != -1 or source_community.lower().find("doctype") != -1:
    exit('Failed to fetch remote source file.')

# parse type list
type_prefix = "k_eControllerType_";
type_first = type_prefix + "UnknownSteamController"
type_last = type_prefix + "LastController"

type_start = source_sdl.index(type_first) + len(type_first)
type_end = source_sdl.index(type_last, type_start)
typelist = source_sdl[type_start:type_end]

# extract types
import re
regex_types = "(?<=" + type_prefix + ")(.*)(?= = )"
list_types = re.findall(regex_types, typelist)

# clean sdl source
source_sdl = source_sdl.replace(" ", "")

# parse vendor and product ids per type
for type in range(len(list_types)):

    # extract ids
    regex_ids = "(?<=MAKE_CONTROLLER_ID.)(.*),(.*)(?=(\)\," + type_prefix + list_types[type] + ",))"
    list_ids = re.findall(regex_ids, source_sdl)

    # skip type if no ids
    if len(list_ids) == 0:
        continue

    # index type
    file_line = (list_types[type] + ",")

    # index id list
    for id in range(len(list_ids)):

        # format vendor and product id
        for i in range(2):

            # clean id
            i_value = (list_ids[id][i]).lower().replace(" ","").replace("   ","").replace("0x","").zfill(4)
            
            # swap endianness
            file_line += i_value[2] + i_value[3] + i_value[0] + i_value[1]

        file_line += ","

    # render line
    print(file_line)

# render community list
print(source_community)
