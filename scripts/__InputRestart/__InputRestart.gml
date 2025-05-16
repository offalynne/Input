// Feather disable all

function __InputRestart()
{
    static _system = __InputSystem();
    with(_system)
    {
        __restartTime = __time;
    }
    
    var _i = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        InputVerbConsumeAll(_i);
            
        ++_i;
    }

    __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.GAME_RESTART);
}
