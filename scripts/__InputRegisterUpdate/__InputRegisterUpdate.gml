// Feather disable all

function __InputRegisterUpdate()
{
    __InputPlugInRegisterCallbackInternal(INPUT_PLUG_IN_CALLBACK.UPDATE, 0, function()
    {
        static _playerArray        = __InputSystemPlayerArray();
        static _virtualButtonArray = __virtualButtonArray;
        static _gamepadArray       = __gamepadArray;
        static _rebindingArray     = __rebindingArray;
        
        __time += delta_time/1000;
        
        ++__frame;
        var _frame = __frame;
        
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
                io_clear();
                
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
        
        //Unstick
        if ((not INPUT_BAN_KBM) && keyboard_check(vk_anykey))
        {
            if (INPUT_ON_WINDOWS)
            {
                if (keyboard_check(vk_alt) && keyboard_check_pressed(vk_space))
                {
                    //Unstick Alt Space
                    keyboard_key_release(vk_alt);
                    keyboard_key_release(vk_space);
                    keyboard_key_release(vk_lalt);
                    keyboard_key_release(vk_ralt);
                }
                
                if (keyboard_check(0xE6) && !keyboard_check_pressed(0xE6))
                {
                    //Unstick OEM key (Power button on Steam Deck)
                    keyboard_key_release(0x0E6);
                }
            }
            else if (INPUT_ON_WEB && INPUT_ON_APPLE)
            {
                if (keyboard_check_released(vk_lmeta) || keyboard_check_released(vk_rmeta))
                {
                    //Meta release sticks every key pressed during hold
                    //This is "the nuclear option", but the problem is severe
                    var _i = 8;
                    var _len = 0x100 - _i;
                    repeat(_len)
                    {
                        keyboard_key_release(_i);
                        ++_i;
                    }
                }
            }
            else if (INPUT_ON_MACOS)
            {
                //Unstick doubled-up control keys
                if (keyboard_check_released(vk_control))
                {
                    keyboard_key_release(vk_lcontrol);
                    keyboard_key_release(vk_rcontrol);
                }
                    
                if (keyboard_check_released(vk_shift))
                {
                    keyboard_key_release(vk_lshift);
                    keyboard_key_release(vk_rshift);
                }
                
                if (keyboard_check_released(vk_alt))
                {
                    keyboard_key_release(vk_lalt);
                    keyboard_key_release(vk_ralt);
                }
                
                //Unstick Meta
                if (keyboard_check_released(vk_lmeta))
                {
                    keyboard_key_release(vk_rmeta);
                }
                else if (keyboard_check_released(vk_rmeta) && keyboard_check(vk_lmeta))
                {
                    keyboard_key_release(vk_lmeta);
                }
            }
        }
        
        if (__usingSteamworks)
        {
            steam_input_run_frame();
            
            if (__InputSteamHandlesChanged())
            {
                __InputTrace("Steam handles changed, disconnecting all gamepads for reconnection");
                
                var _device = 0;
                repeat(array_length(_gamepadArray))
                {
                    if (InputDeviceIsConnected(_device))
                    {
                        __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.GAMEPAD_DISCONNECTED, _device, true);
                    }
                    
                    ++_device;
                }
            }
        }
        
        if ((not INPUT_BAN_GAMEPADS) && (_frame > INPUT_GAMEPADS_TICK_PREDELAY))
        {
            var _deviceCountChange = max(0, gamepad_get_device_count() - array_length(_gamepadArray));
            repeat(_deviceCountChange)
            {
                array_push(_gamepadArray, undefined);
            }
            
            var _device = 0;
            repeat(array_length(_gamepadArray))
            {
                var _gamepad = _gamepadArray[_device];
                var _connected = gamepad_is_connected(_device);
                
                if (_gamepad != undefined)
                {
                    if (_connected)
                    {
                        if (INPUT_ON_SWITCH && (_gamepad.__type != __InputGamepadIdentifySwitchType(_device)))
                        {
                            //When Switch L+R assignment is used to pair two gamepads we won't see a normal disconnection/reconnection
                            //Instead we have to check for changes via the gamepad description or Joy-Con left/right connected state
                            
                            __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.GAMEPAD_DISCONNECTED, _device, true);
                            __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.GAMEPAD_CONNECTED, _device);
                        }
                        
                        _gamepad.__lastConnectedTime = _frame;
                    }
                    else
                    {
                        if (_frame - _gamepad.__lastConnectedTime >= INPUT_GAMEPADS_DISCONNECTION_TIMEOUT)
                        {
                            __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.GAMEPAD_DISCONNECTED, _device, true);
                        }
                    }
                }
                else
                {
                    if (_connected)
                    {
                        __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.GAMEPAD_CONNECTED, _device);
                    }
                }
                
                ++_device;
            }
        }
        
        //Handle rebinding
        var _i = 0;
        repeat(array_length(_rebindingArray))
        {
            _rebindingArray[_i].__Update();
            ++_i;
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
        
        //Handle hotswap
        if ((not INPUT_BAN_HOTSWAP) && __hotswap)
        {
            if (InputPlayerGetInactive())
            {
                var _device = InputDeviceGetNewActivity();
                if (_device != INPUT_NO_DEVICE)
                {
                    InputPlayerSetDevice(_device);
                    if (is_callable(__hotswapCallback)) __hotswapCallback();
                }
            }
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