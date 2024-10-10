// Feather disable all

__InputIconSystem();
function __InputIconSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
        __keyboardIconMap = ds_map_create();
        __gamepadTypeMap  = ds_map_create();
        
        __empty = undefined;
        __unsupported = undefined;
    }
    
    return _system;
}