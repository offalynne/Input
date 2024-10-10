/// @param gamepadIndex
/// @param [description]

function __InputGamepadIdentifySwitchType(_gamepadIndex, _description = gamepad_get_description(_gamepadIndex))
{
    if (_description == "Joy-Con")
    {
        //TODO - GameMaker runtimes in 2024 are reporting single Joy-Cons without the left/right identifier
        //       This is known to affect runtimes:
        //       - v2022.0.2.49
        //       - v2024.8.1.218
        //       It also probably affects runtime:
        //       - v2024.1100.0.658
        
        __InputTrace("Warning! Using stop-gap identification for bad description \"Joy-Con\"");
        
        var _left  = switch_controller_joycon_left_connected( _gamepadIndex);
        var _right = switch_controller_joycon_right_connected(_gamepadIndex);
        
        if (_left)
        {
            if (_right)
            {
                //Both Joy-Cons are connected in dual mode
                return INPUT_GAMEPAD_TYPE_SWITCH;
            }
            else
            {
                return INPUT_GAMEPAD_TYPE_JOYCON_LEFT;
            }
        }
        else
        {
            if (_right)
            {
                return INPUT_GAMEPAD_TYPE_JOYCON_RIGHT;
            }
            else
            {
                __InputTrace("Warning! Invalid left/right Joy-Con state, falling back on handheld");
                return INPUT_GAMEPAD_TYPE_SWITCH;
            }
        }
    }
    else if (_description == "Joy-Con (L)")
    {
        return INPUT_GAMEPAD_TYPE_JOYCON_LEFT;
    }
    else if (_description == "Joy-Con (R)")
    {
        return INPUT_GAMEPAD_TYPE_JOYCON_RIGHT;
    }
    
    return INPUT_GAMEPAD_TYPE_SWITCH;
}