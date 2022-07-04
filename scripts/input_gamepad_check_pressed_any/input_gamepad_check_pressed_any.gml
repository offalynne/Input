/// @desc    Checks if the any button/axis is active this frame
/// @param   gamepadIndex
/// @param   checkAxis

function input_gamepad_check_pressed_any(_gamepad, _check_axis)
{
    if (!gamepad_is_connected(_gamepad)) return false;
    
    if (input_gamepad_check_pressed(_gamepad, gp_face1)
    ||  input_gamepad_check_pressed(_gamepad, gp_face2)
    ||  input_gamepad_check_pressed(_gamepad, gp_face3)
    ||  input_gamepad_check_pressed(_gamepad, gp_face4)
    ||  input_gamepad_check_pressed(_gamepad, gp_padu)
    ||  input_gamepad_check_pressed(_gamepad, gp_padd)
    ||  input_gamepad_check_pressed(_gamepad, gp_padl)
    ||  input_gamepad_check_pressed(_gamepad, gp_padr)
    ||  input_gamepad_check_pressed(_gamepad, gp_shoulderl)
    ||  input_gamepad_check_pressed(_gamepad, gp_shoulderr)
    ||  input_gamepad_check_pressed(_gamepad, gp_start)
    ||  input_gamepad_check_pressed(_gamepad, gp_select)
    ||  input_gamepad_check_pressed(_gamepad, gp_stickl)
    ||  input_gamepad_check_pressed(_gamepad, gp_stickr)
    ||  input_gamepad_check_pressed(_gamepad, gp_shoulderl)
    ||  (!input_gamepad_is_axis(_gamepad, gp_shoulderlb) && input_gamepad_check_pressed(_gamepad, gp_shoulderlb))
    ||  (!input_gamepad_is_axis(_gamepad, gp_shoulderrb) && input_gamepad_check_pressed(_gamepad, gp_shoulderrb)))
    {
        return true;
    }
        
    if (INPUT_SDL2_ALLOW_EXTENDED)
    {
        if (input_gamepad_check_pressed(_gamepad, gp_guide)
        ||  input_gamepad_check_pressed(_gamepad, gp_misc1)
        ||  input_gamepad_check_pressed(_gamepad, gp_touchpad)
        ||  input_gamepad_check_pressed(_gamepad, gp_paddle1)
        ||  input_gamepad_check_pressed(_gamepad, gp_paddle2)
        ||  input_gamepad_check_pressed(_gamepad, gp_paddle3)
        ||  input_gamepad_check_pressed(_gamepad, gp_paddle4))
        {
            return true;
        }
    }

    if (_check_axis)
    {
        if (input_gamepad_check_pressed(_gamepad, gp_shoulderlb)
        ||  input_gamepad_check_pressed(_gamepad, gp_shoulderrb)
        ||  input_gamepad_check_pressed(_gamepad, gp_axislh)
        ||  input_gamepad_check_pressed(_gamepad, gp_axislv)
        ||  input_gamepad_check_pressed(_gamepad, gp_axisrh)
        ||  input_gamepad_check_pressed(_gamepad, gp_axisrv))
        {
            
            return true;
        }
    }

    return false;
}