//Feather disable all

var _device = InputPlayerGetDevice();
var _state = "";

var _i = 0;
repeat(2)
{
    switch(InputTriggerEffectGetState((_i == 0)? gp_shoulderlb : gp_shoulderrb))
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

var _str = "";
_str += "Trigger Effect Test\n";
_str += "\n";
_str += "Gamepad = " + InputDeviceGetDescription(_device) + "\n";
_str += "Type    = " + string(InputDeviceGetGamepadType(_device)) + "\n";
_str += "Support = " + string(InputTriggerEffectGetSupported()) + "\n";
_str += "\n";
_str += "Paused       = " + string(InputTriggerEffectGetPause()) + "\n";
_str += "gp_shoulderl = Resume\n";
_str += "gp_shoulderr = Pause\n";
_str += "\n";
_str += "Left Value  = " + string(InputDeviceGetGamepadValue(_device, gp_shoulderlb))  + "\n";
_str += "Left State  = " + _left_state + "\n";
_str += "\n";
_str += "gp_padd = Left Off\n";
_str += "gp_padr = Left Weapon\n";
_str += "gp_padl = Left Feedback\n";
_str += "gp_padu = Left Vibration\n";
_str += "\n";
_str += "Right Value = " + string(InputDeviceGetGamepadValue(_device, gp_shoulderrb))  + "\n";
_str += "Right State = " + _right_state + "\n";
_str += "\n";
_str += "gp_face1 = Right Off\n";
_str += "gp_face2 = Right Weapon\n";
_str += "gp_face3 = Right Feedback\n";
_str += "gp_face4 = Right Vibration\n";

draw_text(10, 10, _str);