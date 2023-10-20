//Whether to allow (problematic) keyboard input on Android platform
#macro INPUT_ANDROID_KEYBOARD_ALLOWED  false

//Whether to allow keyboard input on Switch platform
#macro INPUT_SWITCH_KEYBOARD_ALLOWED  false

//Whether to merge control keys, for example Left Shift and Right Shift upon user rebind
#macro INPUT_MERGE_CONTROL_KEYS  false

//The following macro controls default key filtering behaviour on platforms supporting keyboard
//Expected values are:
//  0 = Don't ignore any keys
//  1 = Ignore select nonfunctional keys:
//      - Alt/Options (Mac)
//      - Windows/Command (Mac)
//      - Hard/soft Back on Android
//      - PrintSc on iOS/tvOS
//      - Caps lock in browser on Apple platforms
//      - F10 in browser on Apple platforms
//      - F11 in browser on other platforms
//      - Vendor-reserved (0xFF)
//  2 = Ignore all above keys, and reserved and/or system keys:
//      - Num lock & Scroll lock
//      - IME keys
//      - Browser keys
//      - Media keys
//You can modify this list at any time by calling input_ignore_key_add() or input_ignore_key_remove()
//This setting only affects Input and will not filter these keys from native GameMaker functions
#macro INPUT_IGNORE_RESERVED_KEYS_LEVEL  2
