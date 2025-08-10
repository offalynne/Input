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
            if (INPUT_CURSOR_CLUSTER < 0)
            {            
                InputPlugInWarning("Invalid Cursor Cluster Index: \"", INPUT_CURSOR_CLUSTER, "\"");
            }
            else
            {
                InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.UPDATE, -1, function(_playerIndex)
                {
                    var _i = 0;
                    repeat(INPUT_MAX_PLAYERS)
                    {
                        __playerArray[_i].__Update();
                        ++_i;
                    }
                });
            }
        });
    }
    
    return _system;
}