function InputTextRequestStop()
{
    static _system = __InputTextSystem();
    with(_system) return __RequestStop();
    return true;
}