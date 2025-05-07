// Feather disable all

//Coordinate spaces. Room space is conceptually the same as "world space" in other engines. GUI
//space is the GUI layer (Draw GUI etc.). Device space is either window coordinates when the game
//is windowed on a desktop platform, or the entire screen otherwise.
#macro INPUT_CURSOR_ROOM_SPACE    0
#macro INPUT_CURSOR_GUI_SPACE     1
#macro INPUT_CURSOR_DEVICE_SPACE  2

//Limit types that can be applied to a cursor. Please see the `InputCursorLimit*()` functions for
//more details.
#macro INPUT_CURSOR_LIMIT_NONE      0
#macro INPUT_CURSOR_LIMIT_BOUNDARY  1
#macro INPUT_CURSOR_LIMIT_AABB      2
#macro INPUT_CURSOR_LIMIT_CIRCLE    3