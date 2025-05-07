function InputTextRequestGetStatus()
{
    static _system = __InputTextSystem();
    return _system.__requestStatus;
}