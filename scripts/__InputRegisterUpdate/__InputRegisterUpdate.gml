// Feather disable all

function __InputRegisterUpdate()
{
    __InputPlugInRegisterCallbackInternal(INPUT_PLUG_IN_CALLBACK.UPDATE, 0, function()
    {
        static _playerArray        = __InputSystemPlayerArray();
        static _virtualButtonArray = __virtualButtonArray;
        
        __time += delta_time/1000;
        ++__frame;
        
        __pointerBlockedByUserThisFrame = false;
        
        //Handle window state
        if (INPUT_ON_DESKTOP && (not INPUT_ON_WEB))
        {
            if (os_is_paused())
            {
                //Lost focus
                __windowFocus = false;
                __pointerBlockedByWindowDefocus = true;
                
                //Linux app continues to recieve input some number of frames after focus loss
                //Clear IO on focus loss to prevent false positive of subsequent focus regain
                if (INPUT_ON_LINUX)
                {
                    var _keyboardString = keyboard_string;
                    io_clear();
                    keyboard_string = _keyboardString;
                }
                
                //Enable Windows IME
                if (INPUT_ON_WINDOWS)
                {
                    keyboard_virtual_show(undefined, undefined, undefined, undefined);
                }
                
                __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.LOSE_FOCUS);
            }
            else
            {
                if (__windowFocus)
                {
                    if (__pointerBlockedByWindowDefocus)
                    {
                        //Sustain mouse block while a button remains held
                        __pointerBlockedByWindowDefocus = false; //Temporarily turn off blocking
                        __pointerBlockedByWindowDefocus = (__InputGetMouseOutput() != undefined);
                    }
                }
                else if ((keyboard_key != vk_nokey) 
                     ||  (mouse_button != mb_none)
                     ||  (INPUT_ON_WINDOWS && window_has_focus())
                     ||  (INPUT_ON_MACOS   && __pointerMoved))
                {
                    //Regained focus
                    __windowFocus                   = true;
                    __pointerBlockedByWindowDefocus = true;
                    __pointerBlockedByUserThisFrame = true;
                
                    //Disable Windows IME
                    if (INPUT_ON_WINDOWS)
                    {
                        keyboard_virtual_hide();
                    }
                    
                    __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.GAIN_FOCUS);
                }
            }
        }
        
        //Track mouse movement and also fix Windows touchpad / touchscreen problems
        if (not INPUT_BLOCK_MOUSE_CHECKS)
        {
            __prevPointerDeviceX = __pointerDeviceX;
            __prevPointerDeviceY = __pointerDeviceY;
            
            if (__pointerBlockedByUser || (__pointerBlockedByWindowDefocus && (not INPUT_ON_MACOS)) || ((not INPUT_BAN_KBM) && InputDeviceGetRebinding(INPUT_KBM)))
            {
                __pointerBlocked = true;
            }
            else
            {
                __pointerBlocked = false;
                
                __pointerRoomX = device_mouse_x(0);
                __pointerRoomY = device_mouse_y(0);
                __pointerGuiX  = device_mouse_x_to_gui(0);
                __pointerGuiY  = device_mouse_y_to_gui(0);
                
                if (INPUT_ON_WINDOWS)
                {
                    __pointerDeviceX = display_mouse_get_x() - window_get_x();
                    __pointerDeviceY = display_mouse_get_y() - window_get_y();
                }
                else
                {
                    __pointerDeviceX = device_mouse_raw_x(0);
                    __pointerDeviceY = device_mouse_raw_y(0);
                }
            }
            
            __pointerMoved = (point_distance(__prevPointerDeviceX, __prevPointerDeviceY, __pointerDeviceX, __pointerDeviceY) > INPUT_MOUSE_MOVE_DEADZONE);
            
            if (INPUT_ON_WINDOWS)
            {
                //Track clicks from touchpad and touchscreen taps (system-setting dependent)
                __tapPresses  += device_mouse_check_button_pressed( 0, mb_left);
                __tapReleases += device_mouse_check_button_released(0, mb_left);
                
                if (__tapReleases >= __tapPresses)
                {
                    //Resolve press/release desync (where press failed to register on same frame as release)
                    __tapClick    = (__tapReleases > __tapPresses);
                    __tapPresses  = 0;
                    __tapReleases = 0;
                }
                else
                {
                    __tapClick = false;
                }
            }
        }
        
        //Reorder virtual buttons if necessary, from highest priority to lowest
        if (__virtualOrderDirty)
        {
            __virtualOrderDirty = false;
            
            //Clean up any destroyed virtual buttons
            var _i = 0;
            repeat(array_length(_virtualButtonArray))
            {
                if (_virtualButtonArray[_i].__destroyed)
                {
                    array_delete(_virtualButtonArray, _i, 1);
                }
                else
                {
                    ++_i;
                }
            }
            
            array_sort(_virtualButtonArray, function(_a, _b)
            {
                return sign(_b.__priority - _a.__priority);
            });
        }
        
        //Update player state
        __lowestConnectedPlayerIndex = undefined;
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            _playerArray[_i].__Update();
            
            if (__lowestConnectedPlayerIndex == undefined)
            {
                if (InputPlayerIsConnected(_i))
                {
                    __lowestConnectedPlayerIndex = _i;
                }
            }
            
            ++_i;
        }
    });
}
