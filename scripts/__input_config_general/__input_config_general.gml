//PC platforms: Windows, MacOS, Linux, Steam Deck, HTML5 or OperaGX
#macro INPUT_PC_KEYBOARD          true
#macro INPUT_PC_MOUSE             true
#macro INPUT_PC_GAMEPAD           true

#macro INPUT_WINDOWS_TOUCH        false  //Partially supported
#macro INPUT_WINDOWS_VIBRATION    true   //Partially supported (XInput and Steam)

//Mobile platforms: Android, iOS, iPadOS, tvOS, HTML5 or OperaGX
#macro INPUT_MOBILE_GAMEPAD       true
#macro INPUT_MOBILE_MOUSE         false  //Maps touchscreen to mouse

#macro INPUT_MOBILE_WEB_KEYBOARD  false  //Partially supported
#macro INPUT_ANDROID_KEYBOARD     false  //Partially supported

//Switch console platform
#macro INPUT_SWITCH_KEYBOARD      false  //Partially supported over USB
#macro INPUT_SWITCH_MOUSE         false  //Maps touchscreen to mouse
#macro INPUT_SWITCH_TOUCH         false  //Supported for handheld touchscreen
#macro INPUT_SWITCH_VIBRATION     true   //Legacy support (simulated with HD Rumble)

//PlayStation 4 and PlayStation 5 console platforms
#macro INPUT_PS_MOUSE             false  //Partially supported (first player touchpad)
#macro INPUT_PS4_VIBRATION        true
#macro INPUT_PS5_VIBRATION        true   //Legacy support (simulated with PS5 haptics)

//Xbox One and Xbox Series console platforms
#macro INPUT_XBOX_VIBRATION       true


//Whether to allow input while game window is out of focus on desktop platforms
#macro INPUT_ALLOW_OUT_OF_FOCUS  false

//Set to true to use milliseconds instead of frames throughout the library
#macro INPUT_TIMER_MILLISECONDS  false

//Whether to allow using Steamworks extension when available
//This feature requires the Steamworks extension: https://github.com/YoYoGames/GMEXT-Steamworks
#macro INPUT_ALLOW_STEAMWORKS  true

//Time (in milliseconds) to wait for a new binding before automatically cancelling the binding scan
#macro INPUT_BINDING_SCAN_TIMEOUT  10000

//What source mode to start the game in
#macro INPUT_STARTING_SOURCE_MODE  INPUT_SOURCE_MODE.HOTSWAP