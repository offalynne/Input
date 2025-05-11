// Feather disable all

function InputTextCharsRemoved()
{
    static _system = __InputTextSystem();
    with(_system)
    {
        __enabled = true;
        return __removeCount;
    }
    
    return 0;
}