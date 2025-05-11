function InputTextRequestGetString()
{
    static _system = __InputTextSystem();
    with(_system)
    {
        __enabled = true;
        return __textRequest;
    }
    
    return "";
}