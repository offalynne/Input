function InputTextRequestStop()
{
    static _system = __InputTextSystem();
    with(_system)
    {
        __newStatus = INPUT_TEXT_STATUS.STOPPED;
    }

    return true;
}