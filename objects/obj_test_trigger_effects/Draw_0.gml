var _gamepad = input_player_get_gamepad();
var _state = "";

var _i = 0;
repeat(2)
{
    switch (input_trigger_effect_get_state((_i == 0)? gp_shoulderlb : gp_shoulderrb))
    {
        case INPUT_TRIGGER_STATE.EFFECT_OFF:               _state = "off";               break;
        case INPUT_TRIGGER_STATE.EFFECT_FEEDBACK_STANDBY:  _state = "feedback standby";  break;
        case INPUT_TRIGGER_STATE.EFFECT_FEEDBACK_ACTIVE:   _state = "feedback active";   break;
        case INPUT_TRIGGER_STATE.EFFECT_WEAPON_STANDBY:    _state = "weapon standby";    break;
        case INPUT_TRIGGER_STATE.EFFECT_WEAPON_PULLING:    _state = "weapon pulling";    break;
        case INPUT_TRIGGER_STATE.EFFECT_WEAPON_FIRED:      _state = "weapon fired";      break;
        case INPUT_TRIGGER_STATE.EFFECT_VIBRATION_STANDBY: _state = "vibration standby"; break;
        case INPUT_TRIGGER_STATE.EFFECT_VIBRATION_ACTIVE:  _state = "vibration active";  break;
        case INPUT_TRIGGER_STATE.EFFECT_INTERCEPTED:       _state = "intercepted";       break;
        
        default: _state = "undefined"; break;
    }
    
    if (_i == 0) { var _left_state  = _state; }
    else         { var _right_state = _state; }    
    ++_i;
}

var _str_l = "";
_str_l += "Trigger Effect Test\n";
_str_l += "\n";
_str_l += "Gamepad = " + input_gamepad_get_description(_gamepad) + "\n";
_str_l += "Type    = " + input_gamepad_get_type(_gamepad) + "\n";
_str_l += "Support = " + string((input_gamepad_get_type(_gamepad) == "ps5") && (os_type == os_ps5) || global.__input_using_steamworks) + "\n";
_str_l += "\n";
_str_l += "Left Value  = " + string(input_gamepad_value(_gamepad, gp_shoulderlb))  + "\n";
_str_l += "Left State  = " + _left_state + "\n";
_str_l += "\n";
_str_l += "gp_padd = Left Off\n";
_str_l += "gp_padr = Left Weapon\n";
_str_l += "gp_padl = Left Feedback\n";
_str_l += "gp_padu = Left Vibration\n";


var _str_r = "";
_str_r += "Paused       = " + string(input_trigger_effect_get_pause()) + "\n";
_str_r += "gp_shoulderl = Resume\n";
_str_r += "gp_shoulderr = Pause\n";
_str_r += "\n";
_str_r += "Right Value = " + string(input_gamepad_value(_gamepad, gp_shoulderrb))  + "\n";
_str_r += "Right State = " + _right_state + "\n";
_str_r += "\n";
_str_r += "gp_face1 = Right Off\n";
_str_r += "gp_face2 = Right Weapon\n";
_str_r += "gp_face3 = Right Feedback\n";
_str_r += "gp_face4 = Right Vibration\n";
draw_text( 10,  10, _str_l);
draw_text(400,  50, _str_r);
