// Feather disable all

#macro __INPUT_STEAMWORKS_KEY_STRENGTH        "strength"
#macro __INPUT_STEAMWORKS_KEY_AMPLITUDE       "amplitude"
#macro __INPUT_STEAMWORKS_KEY_FREQUENCY       "frequency"
#macro __INPUT_STEAMWORKS_KEY_POSITION        "position"
#macro __INPUT_STEAMWORKS_KEY_START_POSITION  "start_position"
#macro __INPUT_STEAMWORKS_KEY_END_POSITION    "end_position"



function __input_steam_apply_trigger_effect(_steam_handle, _effect, _trigger, _strength)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
        
    //Steam Input uses libScePad for DualSense trigger effects, Windows native only
    if (!__INPUT_ON_WINDOWS || _global.__on_wine || !is_numeric(_steam_handle)) return false;
    
    //Validate gamepad effect and params
    if (not is_struct(_effect)) return false;
    if (not is_struct(variable_struct_get(_effect, "__params"))) return false;

    var _left  = 0;
    var _right = 1;

    static _steam_trigger_params = {};
    static _command_array = [{}, {}];
    
    //Build effect data
    var _key_data = "command_data"
    _command_array[_left   ][$ _key_data] = {};
    _command_array[_right  ][$ _key_data] = {};
    _command_array[_trigger][$ _key_data][$ string(_effect.__mode_name) + "_param"] = _effect.__params;
    
    var _key_mode = "mode"
    _command_array[_left   ][$ _key_mode] = steam_input_sce_pad_trigger_effect_mode_off;
    _command_array[_right  ][$ _key_mode] = steam_input_sce_pad_trigger_effect_mode_off;    
    _command_array[_trigger][$ _key_mode] = _global.__steam_trigger_mode[$ _effect.__mode];
    
    //Apply player strength to effect params
    if (_effect.__params[$ __INPUT_STEAMWORKS_KEY_AMPLITUDE] != undefined) _effect.__params[$ __INPUT_STEAMWORKS_KEY_AMPLITUDE] *= _strength;
    if (_effect.__params[$ __INPUT_STEAMWORKS_KEY_STRENGTH ] != undefined) _effect.__params[$ __INPUT_STEAMWORKS_KEY_STRENGTH ] *= _strength;
    
    //Build command
    _steam_trigger_params[$ "command"] = _command_array;
    
    var _key_trigger_mask = "trigger_mask"
    if (_trigger == _left ) _steam_trigger_params[$ _key_trigger_mask] = steam_input_sce_pad_trigger_effect_trigger_mask_l2;
    if (_trigger == _right) _steam_trigger_params[$ _key_trigger_mask] = steam_input_sce_pad_trigger_effect_trigger_mask_r2;
    
    return steam_input_set_dualsense_trigger_effect(_steam_handle, _steam_trigger_params);
}