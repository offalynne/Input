//Sets the preferred behaviour for input_binding_get() when a player has no profile set
//This typically happens when hotswapping and the player hasn't pressed any buttons/keys/etc. yet
//
//Three options are available:
//  0 = Always return an empty binding if the player has no profile set
//  1 = Prefer INPUT_AUTO_PROFILE_FOR_KEYBOARD for bindings if on desktop OSs, and use gamepad bindings otherwise
//  2 = Prefer INPUT_AUTO_PROFILE_FOR_GAMEPAD for bindings
#macro INPUT_FALLBACK_PROFILE_BEHAVIOR  1

//Names of the default profiles to use when automatically assigning profiles based on the source that a
//player is currently using. Default profiles for sources that you don't intend to use in your game do
//not need to be defined
#macro INPUT_AUTO_PROFILE_FOR_KEYBOARD     "keyboard_and_mouse"
#macro INPUT_AUTO_PROFILE_FOR_MOUSE        "keyboard_and_mouse"
#macro INPUT_AUTO_PROFILE_FOR_GAMEPAD      "gamepad"
#macro INPUT_AUTO_PROFILE_FOR_TOUCH        "touch"
#macro INPUT_AUTO_PROFILE_FOR_MIXED        "mixed"
#macro INPUT_AUTO_PROFILE_FOR_MULTIDEVICE  "multidevice"

//Toggles whether INPUT_KEYBOARD and INPUT_MOUSE should be considered a single source at all times
//For most PC games you'll want to tie the keyboard and mouse together but occasionally having them
//separated out is useful
#macro INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER  true

//Whether to allow default profiles (see below) to contain different verbs. Normally every profile
//should contain a reference to every verb, but for complex games this is inconvenient
#macro INPUT_ALLOW_ASSYMMETRIC_DEFAULT_PROFILES  true