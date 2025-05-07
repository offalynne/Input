function InputTextRequestGetParams()
{
    static _system = __InputTextSystem();
    static _params = {};

    with(_params)
    {
        verbCancel          = _system.__verbCancel;
        verbConfirm         = _system.__verbConfirm;
        surpressVerbs       = _system.__surpressVerbs;
        collectKeyboardText = _system.__collectKeyboardText;
    }

    return _params;
}