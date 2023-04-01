/// @desc    Returns the player gamepad LED pattern
/// @param   gamepadIndex

function input_led_pattern_get(_index)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global

    static _led_pattern = {};
    with (_led_pattern)
    {
        value   = 0;
        pattern = [];
        layout  = "unknown";
    }
    
    if ((_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(_global.__gamepads)))
    {
        return _led_pattern;
    }

    var _gamepad = _global.__gamepads[@ _index];
    if (!is_struct(_gamepad) || (_gamepad.__led_layout == "unknown")) return _led_pattern;

    with (_led_pattern)
    {
        value   = _gamepad.index + _gamepad.__led_offset + 1;
        pattern = _global.__gamepad_led_pattern_dict[$ _gamepad.__led_type][@ _gamepad.index + _gamepad.__led_offset];
        layout  = _gamepad.__led_layout;
    }
    
    return _led_pattern;
}
