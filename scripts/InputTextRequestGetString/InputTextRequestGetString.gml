function InputTextRequestGetString()
{
    static _system = __InputTextSystem();
    with(_system)
    {
        return __textRequest;
    }
    
    return "";
}