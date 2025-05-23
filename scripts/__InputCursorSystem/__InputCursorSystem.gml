// Feather disable all

__InputCursorSystem();
function __InputCursorSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
        __playerArray = array_create_ext(INPUT_MAX_PLAYERS, function(_index)
        {
            return new __InputCursorClassPlayer(_index);
        });
        
        InputPlugInDefine("InputTeam.Cursor", "Input Team", "1.0", "10.0", function()
        {
            try
            {
                InputX(INPUT_CURSOR_CLUSTER);
            }
            catch (_error)
            {
                if (string_pos("Cluster index", _error.message) > 0)
                {
                    _error = "Invalid Cursor Cluster\n\n" + _error.longMessage;
                }
                
                InputPlugInError(_error);
            }
            
            InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.UPDATE, -1, function(_playerIndex)
            {
                var _i = 0;
                repeat(INPUT_MAX_PLAYERS)
                {
                    __playerArray[_i].__Update();
                    ++_i;
                }
            });
        });
    }
    
    return _system;
}