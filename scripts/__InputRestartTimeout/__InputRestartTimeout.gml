// Feather disable all

function __InputRestartTimeout()
{
    static _system = __InputSystem();
    with(_system)
    {
        return (__time - __restartTime < 1000);
    }
    
    return true;
}