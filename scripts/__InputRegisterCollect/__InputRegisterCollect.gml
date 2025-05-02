// Feather disable all

function __InputRegisterCollect()
{
    __InputPlugInRegisterCallbackInternal(INPUT_PLUG_IN_CALLBACK.COLLECT, 0, function()
    {
        static _playerArray = __InputSystemPlayerArray();
        
        static _once = (function()
        {
            //Set a default device for player 0 on boot. This should only happen once
            //Juju: Because setting the player's device triggers a plug-in callback, it's possible for plug-ins
            //      to accidentally create a loop of static initializations that results in a crash on boot.
            //      This is hard to debug for people who haven't seen it before. Moving default device-setting
            //      to a one-time event before the first collect works around this problem but has the downside
            //      of leaving player 0's device state as `INPUT_NO_DEVICE` before the first collect.
            if (INPUT_ON_MOBILE)
            {
                InputPlayerSetDevice(INPUT_TOUCH);
            }
            else if (INPUT_ON_DESKTOP)
            {
                InputPlayerSetDevice(INPUT_KBM);
            }
            else if (INPUT_ON_CONSOLE)
            {
                var _i = 0;
                repeat(gamepad_get_device_count())
                {
                    if (InputDeviceIsConnected(_i)) InputPlayerSetDevice(_i);
                    ++_i;
                }
            }
        })();
        
        //Collect raw verb values from players' devices
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.COLLECT_PLAYER, _i);
            ++_i;
        }
    });
}