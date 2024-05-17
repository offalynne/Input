// Feather disable all
function __input_validate_macros()
{
    #region General
    
    if (!is_bool(INPUT_PC_KEYBOARD))
    {
        __input_error("INPUT_PC_KEYBOARD must be either <true> or <false>");
    }

    if (!is_bool(INPUT_PC_MOUSE))
    {
        __input_error("INPUT_PC_MOUSE must be either <true> or <false>");
    }

    if (!is_bool(INPUT_PC_GAMEPAD))
    {
        __input_error("INPUT_PC_GAMEPAD must be either <true> or <false>");
    }

    if (!is_bool(INPUT_WINDOWS_VIBRATION))
    {
        __input_error("INPUT_WINDOWS_VIBRATION must be either <true> or <false>");
    }

    if (!is_bool(INPUT_MOBILE_GAMEPAD))
    {
        __input_error("INPUT_MOBILE_GAMEPAD must be either <true> or <false>");
    }

    if (!is_bool(INPUT_MOBILE_MOUSE))
    {
        __input_error("INPUT_MOBILE_MOUSE must be either <true> or <false>");
    }

    if (!is_bool(INPUT_MOBILE_WEB_KEYBOARD))
    {
        __input_error("INPUT_MOBILE_WEB_KEYBOARD must be either <true> or <false>");
    }

    if (!is_bool(INPUT_ANDROID_KEYBOARD))
    {
        __input_error("INPUT_ANDROID_KEYBOARD must be either <true> or <false>");
    }

    if (!is_bool(INPUT_SWITCH_KEYBOARD))
    {
        __input_error("INPUT_SWITCH_KEYBOARD must be either <true> or <false>");
    }

    if (!is_bool(INPUT_SWITCH_MOUSE))
    {
        __input_error("INPUT_SWITCH_MOUSE must be either <true> or <false>");
    }

    if (!is_bool(INPUT_SWITCH_TOUCH))
    {
        __input_error("INPUT_SWITCH_TOUCH must be either <true> or <false>");
    }

    if (!is_bool(INPUT_SWITCH_VIBRATION))
    {
        __input_error("INPUT_SWITCH_VIBRATION must be either <true> or <false>");
    }

    if (!is_bool(INPUT_PS4_VIBRATION))
    {
        __input_error("INPUT_PS4_VIBRATION must be either <true> or <false>");
    }

    if (!is_bool(INPUT_PS5_VIBRATION))
    {
        __input_error("INPUT_PS5_VIBRATION must be either <true> or <false>");
    }

    if (!is_bool(INPUT_XBOX_VIBRATION))
    {
        __input_error("INPUT_XBOX_VIBRATION must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_ALLOW_OUT_OF_FOCUS))
    {
        __input_error("INPUT_ALLOW_OUT_OF_FOCUS must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_TIMER_MILLISECONDS))
    {
        __input_error("INPUT_TIMER_MILLISECONDS must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_ALLOW_STEAMWORKS))
    {
        __input_error("INPUT_ALLOW_STEAMWORKS must be either <true> or <false>");
    }
    
    if (!is_numeric(INPUT_BINDING_SCAN_TIMEOUT) || (INPUT_BINDING_SCAN_TIMEOUT < 1000))
    {
        __input_error("INPUT_BINDING_SCAN_TIMEOUT must be a number that is greater than or equal to 1000");
    }
    
    if ((INPUT_STARTING_SOURCE_MODE != INPUT_SOURCE_MODE.FIXED)
    &&  (INPUT_STARTING_SOURCE_MODE != INPUT_SOURCE_MODE.JOIN)
    &&  (INPUT_STARTING_SOURCE_MODE != INPUT_SOURCE_MODE.HOTSWAP)
    &&  (INPUT_STARTING_SOURCE_MODE != INPUT_SOURCE_MODE.MIXED)
    &&  (INPUT_STARTING_SOURCE_MODE != INPUT_SOURCE_MODE.MULTIDEVICE))
    {
        __input_error("INPUT_STARTING_SOURCE_MODE must be a member of the INPUT_SOURCE_MODE enum");
    }
    
    #endregion
    
    
    
    #region Verbs Behaviour
    
    if (!is_numeric(INPUT_MAX_ALTERNATE_BINDINGS) || (floor(INPUT_MAX_ALTERNATE_BINDINGS) != INPUT_MAX_ALTERNATE_BINDINGS) || (INPUT_MAX_ALTERNATE_BINDINGS < 1))
    {
        __input_error("INPUT_MAX_ALTERNATE_BINDINGS must be an integer that is greater than or equal to 1");
    }
    
    if (!is_bool(INPUT_FLEXIBLE_VERB_IMPORT))
    {
        __input_error("INPUT_FLEXIBLE_VERB_IMPORT must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_FLEXIBLE_ALTERNATE_BINDING_IMPORT))
    {
        __input_error("INPUT_FLEXIBLE_ALTERNATE_BINDING_IMPORT must be either <true> or <false>");
    }
    
    if (!is_numeric(INPUT_REPEAT_DEFAULT_DELAY) || (INPUT_REPEAT_DEFAULT_DELAY < 1))
    {
        __input_error("INPUT_REPEAT_DEFAULT_DELAY must be a number that is greater than or equal to 1");
    }
    
    if (!is_numeric(INPUT_REPEAT_DEFAULT_PREDELAY) || (INPUT_REPEAT_DEFAULT_PREDELAY < 1))
    {
        __input_error("INPUT_REPEAT_DEFAULT_PREDELAY must be a number that is greater than or equal to 1");
    }
    
    if (!is_numeric(INPUT_LONG_DELAY) || (INPUT_LONG_DELAY < 1))
    {
        __input_error("INPUT_LONG_DELAY must be a number that is greater than or equal to 1");
    }
    
    if (!is_numeric(INPUT_DOUBLE_DELAY) || (INPUT_DOUBLE_DELAY < 1))
    {
        __input_error("INPUT_DOUBLE_DELAY must be a number that is greater than or equal to 1");
    }
    
    if (!is_numeric(INPUT_QUICK_BUFFER) || (INPUT_QUICK_BUFFER < 1))
    {
        __input_error("INPUT_QUICK_BUFFER must be a number that is greater than or equal to 1");
    }
    
    if (!is_numeric(INPUT_CHORD_DEFAULT_TIME) || (INPUT_CHORD_DEFAULT_TIME < 1))
    {
        __input_error("INPUT_CHORD_DEFAULT_TIME must be a number that is greater than or equal to 1");
    }
    
    if (!is_bool(INPUT_2D_CLAMP))
    {
        __input_error("INPUT_2D_CLAMP must be either <true> or <false>");
    }
    
    if ((INPUT_2D_XY_AXIS_BIAS < 0) || (INPUT_2D_XY_AXIS_BIAS > 1))
    {
        __input_error("INPUT_2D_XY_AXIS_BIAS should be between 0.0 and 1.0 (was ", INPUT_2D_XY_AXIS_BIAS, ")");
    }
    
    if (!is_bool(INPUT_2D_XY_AXIS_BIAS_DIAGONALS))
    {
        __input_error("INPUT_2D_XY_AXIS_BIAS_DIAGONALS must be either <true> or <false>");
    }
    
    #endregion
    
    
    
    #region Profiles
    
    if ((INPUT_FALLBACK_PROFILE_BEHAVIOR != 0)
    &&  (INPUT_FALLBACK_PROFILE_BEHAVIOR != 1)
    &&  (INPUT_FALLBACK_PROFILE_BEHAVIOR != 2)
    &&  (INPUT_FALLBACK_PROFILE_BEHAVIOR != 3))
    {
        __input_error("INPUT_FALLBACK_PROFILE_BEHAVIOR must be 0, 1, 2, or 3");
    }
    
    if (!is_string(INPUT_AUTO_PROFILE_FOR_KEYBOARD) && !is_undefined(INPUT_AUTO_PROFILE_FOR_KEYBOARD))
    {
        __input_error("INPUT_AUTO_PROFILE_FOR_KEYBOARD must be a string (or <undefined> if the profile is to be unavailable)");
    }
    
    if (!is_string(INPUT_AUTO_PROFILE_FOR_MOUSE) && !is_undefined(INPUT_AUTO_PROFILE_FOR_MOUSE))
    {
        __input_error("INPUT_AUTO_PROFILE_FOR_KEYBOARD must be a string (or <undefined> if the profile is to be unavailable)");
    }
    
    if (!is_string(INPUT_AUTO_PROFILE_FOR_GAMEPAD) && !is_undefined(INPUT_AUTO_PROFILE_FOR_GAMEPAD))
    {
        __input_error("INPUT_AUTO_PROFILE_FOR_GAMEPAD must be a string (or <undefined> if the profile is to be unavailable)");
    }
    
    if (!is_string(INPUT_AUTO_PROFILE_FOR_TOUCH) && !is_undefined(INPUT_AUTO_PROFILE_FOR_TOUCH))
    {
        __input_error("INPUT_AUTO_PROFILE_FOR_TOUCH must be a string (or <undefined> if the profile is to be unavailable)");
    }
    
    if (!is_string(INPUT_AUTO_PROFILE_FOR_MIXED) && !is_undefined(INPUT_AUTO_PROFILE_FOR_MIXED))
    {
        __input_error("INPUT_AUTO_PROFILE_FOR_MIXED must be a string (or <undefined> if the profile is to be unavailable)");
    }
    
    if (!is_string(INPUT_AUTO_PROFILE_FOR_MULTIDEVICE) && !is_undefined(INPUT_AUTO_PROFILE_FOR_MULTIDEVICE))
    {
        __input_error("INPUT_AUTO_PROFILE_FOR_MULTIDEVICE must be a string (or <undefined> if the profile is to be unavailable)");
    }
    
    if (!is_bool(INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER))
    {
        __input_error("INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_ALLOW_ASYMMETRIC_DEFAULT_PROFILES))
    {
        __input_error("INPUT_ALLOW_ASYMMETRIC_DEFAULT_PROFILES must be either <true> or <false>");
    }
    
    #endregion
    
    
    
    #region Hotswap
    
    if (!is_numeric(INPUT_HOTSWAP_DELAY) || (INPUT_HOTSWAP_DELAY < 1))
    {
        __input_error("INPUT_HOTSWAP_DELAY must be a number that is greater than or equal to 1");
    }
    
    if (!is_bool(INPUT_HOTSWAP_ON_GAMEPAD_AXIS))
    {
        __input_error("INPUT_HOTSWAP_ON_GAMEPAD_AXIS must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_HOTSWAP_ON_MOUSE_BUTTON))
    {
        __input_error("INPUT_HOTSWAP_ON_MOUSE_BUTTON must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_HOTSWAP_ON_MOUSE_MOVEMENT))
    {
        __input_error("INPUT_HOTSWAP_ON_MOUSE_MOVEMENT must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_HOTSWAP_AUTO_PROFILE))
    {
        __input_error("INPUT_HOTSWAP_AUTO_PROFILE must be either <true> or <false>");
    }
    
    #endregion
    
    
    
    #region Multiplayer
    
    if (!is_numeric(INPUT_MAX_PLAYERS) || (floor(INPUT_MAX_PLAYERS) != INPUT_MAX_PLAYERS) || (INPUT_MAX_PLAYERS < 1))
    {
        __input_error("INPUT_MAX_PLAYERS must be an integer that is greater than or equal to 1");
    }
    
    #endregion
    
    
    
    #region External Data
    
    if (!is_bool(INPUT_SDL2_REMAPPING))
    {
        __input_error("INPUT_SDL2_REMAPPING must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_SDL2_ALLOW_EXTERNAL))
    {
        __input_error("INPUT_SDL2_ALLOW_EXTERNAL must be either <true> or <false>");
    }
    
    if (!is_string(INPUT_SDL2_DATABASE_PATH) && !is_undefined(INPUT_SDL2_DATABASE_PATH))
    {
        __input_error("INPUT_SDL2_DATABASE_PATH must be a string or <undefined>");
    }
    
    if (!is_string(INPUT_CONTROLLER_TYPE_PATH) && !is_undefined(INPUT_CONTROLLER_TYPE_PATH))
    {
        __input_error("INPUT_CONTROLLER_TYPE_PATH must be a string or <undefined>");
    }
    
    if (!is_string(INPUT_BLACKLIST_PATH) && !is_undefined(INPUT_BLACKLIST_PATH))
    {
        __input_error("INPUT_BLACKLIST_PATH must be a string or <undefined>");
    }
    
    #endregion
    
    
    
    #region Keyboard
    
    if (!is_bool(INPUT_ANDROID_KEYBOARD_ALLOWED))
    {
        __input_error("INPUT_ANDROID_KEYBOARD_ALLOWED must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_SWITCH_KEYBOARD_ALLOWED))
    {
        __input_error("INPUT_SWITCH_KEYBOARD_ALLOWED must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_MERGE_CONTROL_KEYS))
    {
        __input_error("INPUT_MERGE_CONTROL_KEYS must be either <true> or <false>");
    }
    
    if ((INPUT_IGNORE_RESERVED_KEYS_LEVEL != 0)
    &&  (INPUT_IGNORE_RESERVED_KEYS_LEVEL != 1)
    &&  (INPUT_IGNORE_RESERVED_KEYS_LEVEL != 2))
    {
        __input_error("INPUT_IGNORE_RESERVED_KEYS_LEVEL must be either 0, 1, or 2");
    }
    
    #endregion
    
    
    
    #region Mouse
    
    if (!is_bool(INPUT_MOUSE_ALLOW_SCANNING))
    {
        __input_error("INPUT_MOUSE_ALLOW_SCANNING must be either <true> or <false>");
    }
    
    if (!is_numeric(INPUT_MOUSE_MOVE_DEADZONE) || (INPUT_MOUSE_MOVE_DEADZONE < 0))
    {
        __input_error("INPUT_MOUSE_MOVE_DEADZONE must be a number that is greater than or equal to 0");
    }
    
    if (!is_bool(INPUT_MOUSE_ALLOW_VIRTUAL_BUTTONS))
    {
        __input_error("INPUT_MOUSE_ALLOW_VIRTUAL_BUTTONS must be either <true> or <false>");
    }
    
    #endregion
    
    
    
    #region Touch
    
    if (!is_numeric(INPUT_MAX_TOUCHPOINTS) || (floor(INPUT_MAX_TOUCHPOINTS) != INPUT_MAX_TOUCHPOINTS) || (INPUT_MAX_TOUCHPOINTS < 1))
    {
        __input_error("INPUT_MAX_TOUCHPOINTS must be an integer that is greater than or equal to 1");
    }
    
    if (!is_numeric(INPUT_TOUCH_EDGE_DEADZONE) || (INPUT_TOUCH_EDGE_DEADZONE < 0))
    {
        __input_error("INPUT_TOUCH_EDGE_DEADZONE must be a number that is greater than or equal to 0");
    }
        
    if (!is_numeric(INPUT_TOUCH_HISTORY_FRAMES) || (floor(INPUT_TOUCH_HISTORY_FRAMES) != INPUT_TOUCH_HISTORY_FRAMES) || (INPUT_TOUCH_HISTORY_FRAMES < 1))
    {
        __input_error("INPUT_TOUCH_HISTORY_FRAMES must be an integer that is greater than or equal to 1");
    }
    
    if (!is_numeric(INPUT_VIRTUAL_BUTTON_MIN_THRESHOLD) || (INPUT_VIRTUAL_BUTTON_MIN_THRESHOLD < 0) || (INPUT_VIRTUAL_BUTTON_MIN_THRESHOLD >= INPUT_VIRTUAL_BUTTON_MAX_THRESHOLD))
    {
        __input_error("INPUT_VIRTUAL_BUTTON_MIN_THRESHOLD must be a number greater than or equal to 0, and less than INPUT_VIRTUAL_BUTTON_MAX_THRESHOLD");
    }
    
    if (!is_numeric(INPUT_VIRTUAL_BUTTON_MAX_THRESHOLD) || (INPUT_VIRTUAL_BUTTON_MAX_THRESHOLD < 0) || (INPUT_VIRTUAL_BUTTON_MAX_THRESHOLD < INPUT_VIRTUAL_BUTTON_MIN_THRESHOLD))
    {
        __input_error("INPUT_VIRTUAL_BUTTON_MAX_THRESHOLD must be a number greater than or equal to 0, and greater than INPUT_VIRTUAL_BUTTON_MIN_THRESHOLD");
    }
    
    if (!is_bool(INPUT_VIRTUAL_KEYBOARD_PREDICTIVE_TEXT_ENABLED))
    {
        __input_error("INPUT_VIRTUAL_KEYBOARD_PREDICTIVE_TEXT_ENABLED must be either <true> or <false>");
    }
    
    if ((INPUT_VIRTUAL_KEYBOARD_AUTOCAPITALIZATION_TYPE != kbv_autocapitalize_none)
    &&  (INPUT_VIRTUAL_KEYBOARD_AUTOCAPITALIZATION_TYPE != kbv_autocapitalize_words)
    &&  (INPUT_VIRTUAL_KEYBOARD_AUTOCAPITALIZATION_TYPE != kbv_autocapitalize_sentences)
    &&  (INPUT_VIRTUAL_KEYBOARD_AUTOCAPITALIZATION_TYPE != kbv_autocapitalize_characters))
    {
        __input_error("INPUT_VIRTUAL_KEYBOARD_AUTOCAPITALIZATION_TYPE must be a virtual keyboard autocapitalization type constant");
    }
    
    #endregion
    
    
    
    #region Gamepads
    
    if (!is_numeric(INPUT_DEFAULT_AXIS_MIN_THRESHOLD) || (INPUT_DEFAULT_AXIS_MIN_THRESHOLD < 0) || (INPUT_DEFAULT_AXIS_MIN_THRESHOLD >= INPUT_DEFAULT_AXIS_MAX_THRESHOLD))
    {
        __input_error("INPUT_DEFAULT_AXIS_MIN_THRESHOLD must be a number greater than or equal to 0, and lesser than INPUT_DEFAULT_AXIS_MAX_THRESHOLD");
    }
    
    if (!is_numeric(INPUT_DEFAULT_AXIS_MAX_THRESHOLD) || (INPUT_DEFAULT_AXIS_MAX_THRESHOLD > 1) || (INPUT_DEFAULT_AXIS_MAX_THRESHOLD < INPUT_DEFAULT_AXIS_MIN_THRESHOLD))
    {
        __input_error("INPUT_DEFAULT_AXIS_MAX_THRESHOLD must be a number less than or equal to 1, and greater than INPUT_DEFAULT_AXIS_MAX_THRESHOLD");
    }
    
    if (!is_numeric(INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD) || (INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD < 0) || (INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD >= INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD))
    {
        __input_error("INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD must be a number greater than or equal to 0, and lesser than INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD");
    }
    
    if (!is_numeric(INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD) || (INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD > 1) || (INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD < INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD))
    {
        __input_error("INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD must be a number less than or equal to 1, and greater than INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD");
    }
    
    if (!is_numeric(INPUT_ANDROID_GAMEPAD_ENUMERATION_INTERVAL) || (INPUT_ANDROID_GAMEPAD_ENUMERATION_INTERVAL < 1))
    {
        __input_error("INPUT_ANDROID_GAMEPAD_ENUMERATION_INTERVAL must be a number that is greater than or equal to 1");
    }
    
    if (!is_bool(INPUT_SWITCH_SWAP_AB))
    {
        __input_error("INPUT_SWITCH_SWAP_AB must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_PS_REGION_SWAP_CONFIRM))
    {
        __input_error("INPUT_PS_REGION_SWAP_CONFIRM must be either <true> or <false>");
    }    
    
    if (!is_bool(INPUT_SWITCH_HORIZONTAL_HOLDTYPE))
    {
        __input_error("INPUT_SWITCH_HORIZONTAL_HOLDTYPE must be either <true> or <false>");
    }
    
    if (!is_bool(INPUT_SWITCH_JOYCON_MOTION_RIGHT_HAND))
    {
        __input_error("INPUT_SWITCH_JOYCON_MOTION_RIGHT_HAND must be either <true> or <false>");
    }
    
    if ((INPUT_GYRO_DEFAULT_AXIS_X != INPUT_GYRO.AXIS_PITCH) && (INPUT_GYRO_DEFAULT_AXIS_X != INPUT_GYRO.AXIS_YAW) && (INPUT_GYRO_DEFAULT_AXIS_X != INPUT_GYRO.AXIS_ROLL))
    {
        __input_error("INPUT_GYRO_DEFAULT_AXIS_X must be either INPUT_GYRO.AXIS_PITCH, INPUT_GYRO.AXIS_YAW, or INPUT_GYRO.AXIS_ROLL");
    }
    
    if ((INPUT_GYRO_DEFAULT_AXIS_Y != INPUT_GYRO.AXIS_PITCH) && (INPUT_GYRO_DEFAULT_AXIS_Y != INPUT_GYRO.AXIS_YAW) && (INPUT_GYRO_DEFAULT_AXIS_Y != INPUT_GYRO.AXIS_ROLL))
    {
        __input_error("INPUT_GYRO_DEFAULT_AXIS_Y must be either INPUT_GYRO.AXIS_PITCH, INPUT_GYRO.AXIS_YAW, or INPUT_GYRO.AXIS_ROLL");
    }
    
    if (!is_numeric(INPUT_GYRO_DEFAULT_SENSITIVITY_X))
    {
        __input_error("INPUT_GYRO_DEFAULT_SENSITIVITY_X must be a number");
    }
    
    if (!is_numeric(INPUT_GYRO_DEFAULT_SENSITIVITY_Y))
    {
        __input_error("INPUT_GYRO_DEFAULT_SENSITIVITY_Y must be a number");
    }
    
    #endregion
    
    
    
    #region Cursor
    
    if (!is_string(INPUT_CURSOR_VERB_UP) && !is_undefined(INPUT_CURSOR_VERB_UP))
    {
        __input_error("INPUT_CURSOR_VERB_UP must be a string or <undefined>");
    }
    
    if (!is_string(INPUT_CURSOR_VERB_DOWN) && !is_undefined(INPUT_CURSOR_VERB_DOWN))
    {
        __input_error("INPUT_CURSOR_VERB_DOWN must be a string or <undefined>");
    }
    
    if (!is_string(INPUT_CURSOR_VERB_LEFT) && !is_undefined(INPUT_CURSOR_VERB_LEFT))
    {
        __input_error("INPUT_CURSOR_VERB_LEFT must be a string or <undefined>");
    }
    
    if (!is_string(INPUT_CURSOR_VERB_RIGHT) && !is_undefined(INPUT_CURSOR_VERB_RIGHT))
    {
        __input_error("INPUT_CURSOR_VERB_RIGHT must be a string or <undefined>");
    }
    
    if (!is_numeric(INPUT_CURSOR_START_SPEED) || (INPUT_CURSOR_START_SPEED <= 0))
    {
        __input_error("INPUT_CURSOR_START_SPEED must be a number that is greater than 0");
    }
    
    if (!is_numeric(INPUT_CURSOR_EXPONENT))
    {
        __input_error("INPUT_CURSOR_START_SPEED must be a number");
    }
    
    #endregion
    
    
    
    #region Vibration
    
    if (!is_numeric(INPUT_VIBRATION_DEFAULT_STRENGTH) || (INPUT_VIBRATION_DEFAULT_STRENGTH < 0) || (INPUT_VIBRATION_DEFAULT_STRENGTH > 1.0))
    {
        __input_error("INPUT_VIBRATION_DEFAULT_STRENGTH must be a number between 0.0 and 1.0 (inclusive)");
    }
    
    if (!is_numeric(INPUT_VIBRATION_JOYCON_STRENGTH) || (INPUT_VIBRATION_JOYCON_STRENGTH < 0) || (INPUT_VIBRATION_JOYCON_STRENGTH > 1.0))
    {
        __input_error("INPUT_VIBRATION_JOYCON_STRENGTH must be a number between 0.0 and 1.0 (inclusive)");
    }
    
    if (!is_numeric(INPUT_TRIGGER_EFFECT_DEFAULT_STRENGTH) || (INPUT_TRIGGER_EFFECT_DEFAULT_STRENGTH < 0) || (INPUT_TRIGGER_EFFECT_DEFAULT_STRENGTH > 1.0))
    {
        __input_error("INPUT_TRIGGER_EFFECT_DEFAULT_STRENGTH must be a number between 0.0 and 1.0 (inclusive)");
    }
    
    #endregion
}
