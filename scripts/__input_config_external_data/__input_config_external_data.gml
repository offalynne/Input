//Whether to use Input's own SDL2 database to remap gamepads, overriding the old and crusty
//database that GameMaker uses internally. Setting this to <false> will cause Input to use
//GameMaker's native database and, as a result, gamepad mapping data will be less accurate
#macro INPUT_SDL2_REMAPPING  true

//Whether to allow external SDL2 database loading from environment variable %SDL_GAMECONTROLLERCONFIG%
//This is useful for compatibility with external gamepad mapping software
#macro INPUT_SDL2_ALLOW_EXTERNAL  true

//Whether to allow identified non-gamepad joystick devices including wheels, flightsticks, throttles
#macro INPUT_SDL2_ALLOW_NONGAMEPAD_JOYSTICKS  false

//The following macros hold the names of various source files that Input uses to hold gamepad data
#macro INPUT_SDL2_DATABASE_PATH    "sdl2.txt"                //Path to the SDL2 database to read gamepad remapping definitions from
#macro INPUT_CONTROLLER_TYPE_PATH  "controllertypes.csv"     //Path to the controller type database to read gamepad types from
#macro INPUT_BLACKLIST_PATH        "controllerblacklist.csv" //Path to the controller blacklist database to read from
