// Feather disable all

// Stops text request

function InputTextRequestStop()
{
    static _system = __InputTextSystem();
    with(_system)
    {
        __enabled           = true;
        __steamAsyncRequest = false;
        __asyncId           = undefined;
        __newStatus         = INPUT_TEXT_STATUS.STOPPED;
    }
}