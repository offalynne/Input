// Feather disable all

function InputTextDelta()
{
    static _system = __InputTextSystem();
    with(_system)
    {
        __enabled = true;
        return __textDelta;
    }
    
    return "";
}