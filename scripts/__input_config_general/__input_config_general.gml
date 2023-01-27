//Whether to allow input while game window is out of focus on desktop platforms
#macro INPUT_ALLOW_OUT_OF_FOCUS false

//Set to true to use milliseconds instead of frames throughout the library
#macro INPUT_TIMER_MILLISECONDS  false

//Whether to allow using Steamworks extension when available
//This feature requires the Steamworks extension: https://github.com/YoYoGames/GMEXT-Steamworks
#macro INPUT_ALLOW_STEAMWORKS  true

//Time (in milliseconds) to wait for a new binding before automatically cancelling the binding scan
#macro INPUT_BINDING_SCAN_TIMEOUT  10000

//What source mode to start the game in
#macro INPUT_STARTING_SOURCE_MODE  INPUT_SOURCE_MODE.HOTSWAP





#region Forbidden Fruit

#macro INPUT_2D_CHECKER_STATIC_RESULT  true

#macro INPUT_DEBUG_PROFILES  false
#macro INPUT_DEBUG_SOURCES   false
#macro INPUT_DEBUG_BINDING   false
#macro INPUT_DEBUG_VERBS     false

#macro INPUT_EXTERNAL_DEBUG_LOG  false  //Do NOT set to <true> unless directed (!)
#macro INPUT_WARNING_DEPRECATED  true   //Whether to show errors when using deprecated functions

//How many frames to wait before scanning for connected gamepads
//This works around Steam sometimes reporting confusing connection/disconnection events on boot
#macro INPUT_GAMEPADS_TICK_PREDELAY  10     

#endregion