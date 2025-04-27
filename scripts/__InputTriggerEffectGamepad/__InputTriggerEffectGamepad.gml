// Feather disable all

/// @param device

function __InputTriggerEffectGamepad(_device) constructor
{
    static _system = __InputSystem();
    static _triggerModeMap = (function()
    {
        var _map = ds_map_create();
        
        if (InputGetSteamInfo(INPUT_STEAM_INFO.STEAMWORKS))
        {
            _map[? __INPUT_TRIGGER_EFFECT.__TYPE_OFF      ] = steam_input_sce_pad_trigger_effect_mode_off;
            _map[? __INPUT_TRIGGER_EFFECT.__TYPE_FEEDBACK ] = steam_input_sce_pad_trigger_effect_mode_feedback;
            _map[? __INPUT_TRIGGER_EFFECT.__TYPE_WEAPON   ] = steam_input_sce_pad_trigger_effect_mode_weapon;
            _map[? __INPUT_TRIGGER_EFFECT.__TYPE_VIBRATION] = steam_input_sce_pad_trigger_effect_mode_vibration;
        }
        
        return _map;
    })();
    
    
    
    __device = _device;
    
    
    
    static __Apply = function(_trigger, _effect, _strength)
    {
        var _triggerIndex = 1;
        if (_trigger == gp_shoulderlb)
        {
            _triggerIndex = 0;
        }
        else if (_trigger != gp_shoulderrb)
        {
            __InputError("Value ", _trigger ," not a gamepad trigger");
            return false;
        }

        if (INPUT_ON_PS5)
        {
            return _effect.__ApplyPS5(__device, _trigger, _strength);
        }
        else if (InputGetSteamInfo(INPUT_STEAM_INFO.STEAMWORKS))
        {
            var _steamHandle = InputDeviceGetSteamHandle(__device);
            
            //Steam Input uses libScePad for DualSense trigger effects, Windows native only
            if ((not INPUT_ON_WINDOWS) || InputGetSteamInfo(INPUT_STEAM_INFO.ON_WINE) || (_steamHandle == undefined)) return false;
    
            //Validate gamepad effect and params
            if (not is_struct(_effect)) return false;
            if (not is_struct(_effect[$ "__params"])) return false;

            var _left  = 0;
            var _right = 1;

            static _steam_trigger_params = {};
            static _command_array = [{}, {}];
    
            //Build effect data
            var _key_data = "command_data"
            _command_array[_left        ][$ _key_data] = {};
            _command_array[_right       ][$ _key_data] = {};
            _command_array[_triggerIndex][$ _key_data][$ string(_effect.__modeName) + "_param"] = _effect.__params;
    
            var _key_mode = "mode"
            _command_array[_left        ][$ _key_mode] = steam_input_sce_pad_trigger_effect_mode_off;
            _command_array[_right       ][$ _key_mode] = steam_input_sce_pad_trigger_effect_mode_off;    
            _command_array[_triggerIndex][$ _key_mode] = _triggerModeMap[? _effect.__mode];
    
            //Apply player strength to effect params
            if (_effect.__params[$ __INPUT_TRIGGER_EFFECT_KEY_AMPLITUDE] != undefined) _effect.__params[$ __INPUT_TRIGGER_EFFECT_KEY_AMPLITUDE] *= _strength;
            if (_effect.__params[$ __INPUT_TRIGGER_EFFECT_KEY_STRENGTH ] != undefined) _effect.__params[$ __INPUT_TRIGGER_EFFECT_KEY_STRENGTH ] *= _strength;
    
            //Build command
            _steam_trigger_params[$ "command"] = _command_array;
    
            var _key_trigger_mask = "trigger_mask";
            if (_triggerIndex == _left ) _steam_trigger_params[$ _key_trigger_mask] = steam_input_sce_pad_trigger_effect_trigger_mask_l2;
            if (_triggerIndex == _right) _steam_trigger_params[$ _key_trigger_mask] = steam_input_sce_pad_trigger_effect_trigger_mask_r2;
            
            return steam_input_set_dualsense_trigger_effect(_steamHandle, _steam_trigger_params);
        }

        return false;
    }
}