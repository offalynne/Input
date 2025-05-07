function __InputTextAsyncSteam()
{
    static _system = __InputTextSystem();

    if (async_load[? "event_type"] == "gamepad_text_input_dismissed")
    {
        var _submitted = async_load[? "submitted"];
        with(_system)
        {
            if (!_submitted)
            {
                __requestStatus = INPUT_TEXT_REQUEST_STATUS.CANCELLED;
            }
            else
            {
                __requestStatus = INPUT_TEXT_REQUEST_STATUS.CONFIRMED;
                __textAsync = string_copy(steam_get_entered_gamepad_text_input(), 1, __maxLength);
            }

            __Callback();
            __awaitingSteamRequest = false;
        }
    }
}