// Feather disable all
/// @desc    Returns the player gamepad LED pattern
/// @param   gamepadIndex

function input_led_pattern_get(_index)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global

    static _led_pattern_unknown = {
        value:   0,
        pattern: [],
        layout:  "unknown",
    }
    
    if ((_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(_global.__gamepads)))
    {
        return _led_pattern_unknown;
    }

    var _gamepad = _global.__gamepads[@ _index];
    if not (is_struct(_gamepad)) return _led_pattern_unknown;

    return _gamepad.__led_pattern ?? _led_pattern_unknown;
}
