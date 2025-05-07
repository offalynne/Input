function InputTextRequestSetParams(_verbCancel = undefined, _verbConfirm  = undefined, _surpressVerbs = true, _collectKeyboardText = true)
{
    static _system = __InputTextSystem();
    with(_system)
    {
        __verbCancel           = _verbCancel;
        __verbConfirm          = _verbConfirm;
        __surpressVerbs        = _surpressVerbs;
        __collectKeyboardText  = _collectKeyboardText;
    }
}