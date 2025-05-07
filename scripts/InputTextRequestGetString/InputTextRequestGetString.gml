function InputTextRequestGetString()
{
    static _system = __InputTextSystem();
    with(_system)
    {
        if (__textAsync != undefined) return __textAsync;
        if (__textSet   != undefined) return __textSet;
        return __textRequest;
    }
    
    return "";
}