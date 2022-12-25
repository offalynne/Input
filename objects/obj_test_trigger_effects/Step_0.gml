var _gamepad = input_player_get_gamepad();
if (_gamepad >= 0)
{
    var _pan = input_value("right") - input_value("left");
    
    if (input_gamepad_check_pressed(_gamepad, gp_padd))
    {
        input_trigger_effect_off(gp_shoulderlb);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_padr))
    {
        input_trigger_effect_weapon(gp_shoulderlb, 0.2, 0.3, 1);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_padl))
    {
        input_trigger_effect_feedback(gp_shoulderlb, 0.3, 0.5);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_padu))
    {
        input_trigger_effect_vibration(gp_shoulderlb, 0.3, 0.5, 0.125);
    }    
    
    if (input_gamepad_check_pressed(_gamepad, gp_face1))
    {
        input_trigger_effect_off(gp_shoulderrb);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_face2))
    {
        input_trigger_effect_weapon(gp_shoulderrb, 0.7, 0.8, 1);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_face3))
    {
        input_trigger_effect_feedback(gp_shoulderrb, 0.7, 1);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_face4))
    {
        input_trigger_effect_vibration(gp_shoulderrb, 0.75, 1, 0.66);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_shoulderl))
    {
       input_trigger_effect_set_pause(false);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_shoulderr))
    {
       input_trigger_effect_set_pause(true);
    }
}