# Library Constants

&nbsp;

## General Purpose

|Name                      |Description                                                                                                   |
|--------------------------|--------------------------------------------------------------------------------------------------------------|
|`INPUT_VERSION`           |What version of Input you're running                                                                          |
|`INPUT_DATE`              |Date that this version of Input was released                                                                  |
|`INPUT_RUNNING_FROM_IDE`  |Whether the game is running from the GameMaker IDE                                                            |
|`INPUT_SDL_SUPPORT`       |Whether SDL gamemap remapping is supported on this platform                                                   |
|`INPUT_BLOCK_MOUSE_CHECKS`|Whether mouse/touch input is blocked on this platform                                                         |
|`INPUT_ALL_PLAYERS`       |Signifies "all players" in a game. This has the value `-3` to match the legacy native GameMaker constant `all`|

&nbsp;

## Device Types

Please see the [Devices](Devices) page for more information.

|Name                  |Description                                                                 |
|----------------------|----------------------------------------------------------------------------|
|`INPUT_NO_DEVICE`     |No valid device or the absence of a device. Equal to `-666`                 |
|`INPUT_KBM`           |Keyboard and mouse (which is considerd to be a single device). Equal to `-1`|
|`INPUT_TOUCH`         |Touchscreen input. Equal to `-2`                                            |
|`INPUT_GENERIC_DEVICE`|A generic customisable device. Equal to `-3`                                |

&nbsp;

## Gamepad Types

|Name                             |Description                                                                                                                                                        |
|---------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_GAMEPAD_TYPE_NO_GAMEPAD`  |Special gamepad type to indicate an invalid or disconnected gamepad. Equal to `0`                                                                                  |
|`INPUT_GAMEPAD_TYPE_UNKNOWN`     |Special gamepad type to indicate a connected but unrecognised gamepad. Equal to `1`                                                                                |
|`INPUT_GAMEPAD_TYPE_XBOX`        |An Xbox-type gamepad; either Xbox 360, Xbox One, or Xbox Series X/S. This value is also used for most XInput gamepads on Windows. Equal to `2`                     |
|`INPUT_GAMEPAD_TYPE_PS4`         |A DualShock 4 gamepads, or a gamepad with the same layout and button symbols. Equal to `3`                                                                         |
|`INPUT_GAMEPAD_TYPE_PS5`         |A DualSense 5 gamepad, or a gamepad with the same layout and button symbols. Equal to `4`                                                                          |
|`INPUT_GAMEPAD_TYPE_SWITCH`      |A "two handed" Switch gamepad. This includes a Switch console in handheld format, dual JoyCons, a Switch Pro gamepad, or similar third party gamepads. Equal to `5`|
|`INPUT_GAMEPAD_TYPE_JOYCON_LEFT` |The left-hand Switch JoyCon. Equals to `6`                                                                                                                         |
|`INPUT_GAMEPAD_TYPE_JOYCON_RIGHT`|The right-hand Switch JoyCon. Equals to `7`                                                                                                                        |

&nbsp;

## Device Support

|Name                    |Description                                                                                                                  |
|------------------------|-----------------------------------------------------------------------------------------------------------------------------|
|`INPUT_SUPPORT_GAMEPADS`|Whether gamepads are supported by Input on this platform                                                                     |
|`INPUT_SUPPORT_KBM`     |Whether keyboard and mouse devices are supported by Input on this platform                                                   |
|`INPUT_SUPPORT_TOUCH`   |Whether touchscreen input is supported by Input on this platform                                                             |
|`INPUT_SUPPORT_HOTSWAP` |Whether hotswapping is supported by Input on this platform (at the time of writing, hotswapping is banned on iOS and Android)|

&nbsp;

## Player Status

These values are returned by `InputPlayerGetStatus()`.

|Name                                    |Description                                                |
|----------------------------------------|-----------------------------------------------------------|
|`INPUT_PLAYER_STATUS.DISCONNECTED`      |Player is disconnected and has been for at least two frames|
|`INPUT_PLAYER_STATUS.NEWLY_DISCONNECTED`|Player was disconnected this frame                         |
|`INPUT_PLAYER_STATUS.NEWLY_CONNECTED`   |Player was connected this frame                            |
|`INPUT_PLAYER_STATUS.CONNECTED`         |Player is connected and has been for at least two frames   |

&nbsp;

## Steamworks

You can read more about setting up and using Steamworks with Input [here](Steamworks).

|Name                      |Description                                                                                                                                                                  |
|--------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_STEAMWORKS_SUPPORT`|Whether Steamworks is supported on this platform. **N.B.** This is only a platform check. Please use `InputGetSteamInfo()` to test if Steamworks has initialized successfully|

|Name                         |Description                                                                                  |
|-----------------------------|---------------------------------------------------------------------------------------------|
|`INPUT_STEAM_INFO.STEAMWORKS`|Requests the initialization state for Steamworks as a whole                                  |
|`INPUT_STEAM_INFO.STEAM_DECK`|Requests whether the game is running on a Steam Deck                                         |
|`INPUT_STEAM_INFO.ON_WINE`   |Requests whether the game is running via the [WINE utility](https://www.winehq.org/) on Linux|

&nbsp;

## Plug-in Callbacks

These constants are used when registering callback functions using the [Callback API](Functions-(Plug-ins)).

|Name                                          |Description                                                                                     |
|----------------------------------------------|------------------------------------------------------------------------------------------------|
|`INPUT_PLUG_IN_CALLBACK.COLLECT`              |Called when collecting raw input from devices                                                   |
|`INPUT_PLUG_IN_CALLBACK.UPDATE`               |Called when the library is updating verb state based on raw input from the previous callback    |
|`INPUT_PLUG_IN_CALLBACK.GAMEPAD_DISCONNECTED` |Called once when a player's gamepad has been disconnected                                       |
|`INPUT_PLUG_IN_CALLBACK.GAMEPAD_CONNECTED`    |Called once when a player's gamepad has been connected                                          |
|`INPUT_PLUG_IN_CALLBACK.PLAYER_DEVICE_CHANGED`|Called when a player's device has been changed                                                  |
|`INPUT_PLUG_IN_CALLBACK.COLLECT_PLAYER`       |Called when a player's raw input state is being collected from their device                     |
|`INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER`        |Called when a player's verb state is being updated based on raw input from the previous callback|
|`INPUT_PLUG_IN_CALLBACK.LOSE_FOCUS`           |Called when the game loses focus                                                                |
|`INPUT_PLUG_IN_CALLBACK.GAIN_FOCUS`           |Called when the game regains focus                                                              |

&nbsp;

## Platform

|Name              |Description                                                           |
|------------------|----------------------------------------------------------------------|
|`INPUT_ON_WINDOWS`|Whether the game is running on Windows                                |
|`INPUT_ON_MACOS`  |Whether the game is running on MacOS                                  |
|`INPUT_ON_LINUX`  |Whether the game is running on Linux                                  |
|`INPUT_ON_DESKTOP`|Whether the game is running on Window, MacOS, or Linux                |
|`INPUT_ON_IOS`    |Whether the game is running on iOS                                    |
|`INPUT_ON_ANDROID`|Whether the game is running on Android                                |
|`INPUT_ON_MOBILE` |Whether the game is running on iOS or Android                         |
|`INPUT_ON_XBOX`   |Whether the game is running on Xbox One or Xbox Series X/S            |
|`INPUT_ON_PS4`    |Whether the game is running on PlayStation 4                          |
|`INPUT_ON_PS5`    |Whether the game is running on PlayStation 5                          |
|`INPUT_ON_SWITCH` |Whether the game is running on Nintendo Switch                        |
|`INPUT_ON_CONSOLE`|Whether the game is running on an Xbox, PlayStation, or Switch console|
|`INPUT_ON_APPLE`  |Whether the game is running on MacOS or iOS                           |
|`INPUT_ON_OPERAGX`|Whether the game is running on the OperaGX (WebASM) target            |
|`INPUT_ON_WEB`    |Whether the game is running in any browser                            |

&nbsp;

## Virtual Buttons

These constants are used with the [virtual button](Functions-(Virtual-Buttons)) system.

|Name                                |Description                                                           |
|------------------------------------|----------------------------------------------------------------------|
|`INPUT_VIRTUAL_TYPE.BUTTON`         |Simple tappable button                                                |
|`INPUT_VIRTUAL_TYPE.DPAD_4DIR`      |Dpad that allows for 4-directional input                              |
|`INPUT_VIRTUAL_TYPE.DPAD_8DIR`      |Dpad that allows for 8-directional input                              |
|`INPUT_VIRTUAL_TYPE.DPAD_HORIZONTAL`|Dpad that allows for left/right input only                            |
|`INPUT_VIRTUAL_TYPE.DPAD_VERTICAL`  |Dpad that allows for up/down input only                               |
|`INPUT_VIRTUAL_TYPE.THUMBSTICK`     |Thumbstick replication that allows for smooth 360-degree movement     |
|`INPUT_VIRTUAL_TYPE.TOUCHPAD`       |Touchable region that allows for the control of e.g. an in-game cursor|

|Name                                 |Description                                                                        |
|-------------------------------------|-----------------------------------------------------------------------------------|
|`INPUT_VIRTUAL_REFERENCE.CENTER`     |Use the center of the virtual button to calculate the x/y output                   |
|`INPUT_VIRTUAL_REFERENCE.TOUCH_POINT`|Use the point where the player touched a virtual button to calculate the x/y output|
|`INPUT_VIRTUAL_REFERENCE.DELTA`      |Use the frame-to-frame change in finger position to calculate the x/y output       |

|Name                                  |Description                                                                        |
|--------------------------------------|-----------------------------------------------------------------------------------|
|`INPUT_VIRTUAL_RELEASE.DO_NOTHING`    |Do nothing when a virtual button is released                                       |
|`INPUT_VIRTUAL_RELEASE.DESTROY`       |Destroy the virtual button when it is released                                     |
|`INPUT_VIRTUAL_RELEASE.RESET_POSITION`|When released, move the virtual button back to where it started when it was pressed|

&nbsp;

## Device Support

|Name                |Description                                                                                                               |
|--------------------|--------------------------------------------------------------------------------------------------------------------------|
|`INPUT_BAN_GAMEPADS`|Whether gamepads are banned by Input on this platform                                                                     |
|`INPUT_BAN_KBM`     |Whether keyboard and mouse devices are banned by Input on this platform                                                   |
|`INPUT_BAN_TOUCH`   |Whether touchscreen input is banned by Input on this platform                                                             |
|`INPUT_BAN_HOTSWAP` |Whether hotswapping is banned by Input on this platform (at the time of writing, hotswapping is banned on iOS and Android)|

&nbsp;

## Gamepads

|Name                                  |Description                                                                                                                                                  |
|--------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_GAMEPADS_TICK_PREDELAY`        |How many frames to wait before scanning for connected gamepads. This works around Steam sometimes reporting confusing connection/disconnection events on boot|
|`INPUT_GAMEPADS_DISCONNECTION_TIMEOUT`|How many frames to wait before considering a gamepad disconnected. This works around momentary disconnections such as a jiggled cable or low battery level   |
|`INPUT_GAMEPAD_BINDING_MIN`           |Index of the smallest gamepad button/axis to scan for. At the time of writing, this is equal to `gp_face1`                                                   |
|`INPUT_GAMEPAD_BINDING_MAX`           |Index of the largest gamepad button/axis to scan for. At the time of writing this is equal to `gp_extra6`                                                    |

&nbsp;

## Keyboard Keys

|Name           |Description                                        |
|---------------|---------------------------------------------------|
|`vk_clear`     |Keycode for the numpad "clear" key                 |
|`vk_capslock`  |Keycode for the "caps lock" key                    |
|`vk_menu`      |Keycode for the "menu" key                         |
|`vk_scrollock` |Keycode for the "scroll lock" key                  |
|`vk_semicolon` |Keycode for the semicolon `;` key                  |
|`vk_comma`     |Keycode for the comma `,` key                      |
|`vk_fslash`    |Keycode for the front slash `/` key                |
|`vk_bslash`    |Keycode for the backslack `\` key                  |
|`vk_lbracket`  |Keycode for the left bracket `(` key               |
|`vk_rbracket`  |Keycode for the right bracket `)` key              |
|`vk_apostrophe`|Keycode for the apostrophe `'` key                 |
|`vk_equals`    |Keycode for the equals `=` key                     |
|`vk_numlock`   |Keycode for the "num lock" key                     |
|`vk_hyphen`    |Keycode for the hyphen `-` key                     |
|`vk_rmeta`     |Keycode for the "right meta" key                   |
|`vk_backtick`  |Keycode for the backtick `\`` key                  |
|`vk_lmeta`     |Keycode for the "left meta" key                    |
|`vk_period`    |Keycode for the period (full stop) `.` key         |
|`mb_wheel_up`  |Mouse button code for scrolling the mousewheel up  |
|`mb_wheel_down`|Mouse button code for scrolling the mousewheel down|

|Name               |Description                   |
|-------------------|------------------------------|
|`INPUT_KEYCODE_MIN`|Smallest keycode that is valid|
|`INPUT_KEYCODE_MAX`|Largest keycode that is valid |