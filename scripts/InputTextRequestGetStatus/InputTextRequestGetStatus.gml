// Feather disable all

function InputTextRequestGetStatus()
{
    static _system = __InputTextSystem();
    with(_system)
    {
        __enabled = true;
        return __requestStatus;
    }
    
    return undefined;
}