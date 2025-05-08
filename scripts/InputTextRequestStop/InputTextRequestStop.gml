function InputTextRequestStop()
{
    static _system = __InputTextSystem();
    with(_system)
    {
        __newStatus = INPUT_TEXT_REQUEST_STATUS.STOPPED;
    }

    return true;
}