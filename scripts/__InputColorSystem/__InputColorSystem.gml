// Feather disable all

__InputColorSystem();
function __InputColorSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
        __playerArray = array_create_ext(INPUT_MAX_PLAYERS, function(_index)
        {
            return new __InputColorClassPlayer(_index);
        });
        
        InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.PLAYER_DEVICE_CHANGED, undefined, function(_playerIndex, _oldDevice, _newDevice)
        {
            with(__playerArray[_playerIndex])
            {
                __SetColor(__color);
            }
        });
    }
    
    return _system;
}