// Feather disable all

enum __INPUT_TRIGGER_EFFECT
{
    __TYPE_OFF,
    __TYPE_FEEDBACK,
    __TYPE_WEAPON,
    __TYPE_VIBRATION,
}

#macro __INPUT_TRIGGER_EFFECT_KEY_STRENGTH        "strength"
#macro __INPUT_TRIGGER_EFFECT_KEY_AMPLITUDE       "amplitude"
#macro __INPUT_TRIGGER_EFFECT_KEY_FREQUENCY       "frequency"
#macro __INPUT_TRIGGER_EFFECT_KEY_POSITION        "position"
#macro __INPUT_TRIGGER_EFFECT_KEY_START_POSITION  "start_position"
#macro __INPUT_TRIGGER_EFFECT_KEY_END_POSITION    "end_position"

__InputTriggerEffectSystem();
function __InputTriggerEffectSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
        __deviceMap = ds_map_create();
        
        __playerArray = array_create_ext(INPUT_MAX_PLAYERS, function(_index)
        {
            return new __InputTriggerEffectPlayer(_index);
        });
        
        InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.GAMEPAD_CONNECTED, undefined, function(_device)
        {
            __deviceMap[? _device] = new __InputTriggerEffectGamepad(_device);
        });
        
        InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.GAMEPAD_DISCONNECTED, undefined, function(_device, _actuallyDisconnected)
        {
            ds_map_delete(__deviceMap, _device);
        });
        
        InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.LOSE_FOCUS, undefined, function()
        {
            __InputTriggerEffectStop();
        });
        
        InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.GAIN_FOCUS, undefined, function()
        {
            __InputTriggerEffectReapply(INPUT_ALL_PLAYERS);
        });
        
        InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.PLAYER_DEVICE_CHANGED, undefined, function(_playerIndex, _oldDevice, _newDevice)
        {
            __InputTriggerEffectStop(_oldDevice);
            __InputTriggerEffectReapply(_playerIndex);
        });
    }
    
    return _system;
}