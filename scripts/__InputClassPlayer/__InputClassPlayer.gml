// Feather disable all

/// @param playerIndex

function __InputClassPlayer(_playerIndex) constructor
{
    static _system                 = __InputSystem();
    static _verbCount              = _system.__verbCount;
    static _clusterCount           = _system.__clusterCount;
    static _virtualButtonArray     = _system.__virtualButtonArray;
    static _clusterDefinitionArray = _system.__clusterDefinitionArray;
    
    __playerIndex = _playerIndex;
    
    __device        = INPUT_NO_DEVICE;
    __metadata      = undefined;
    __status        = INPUT_PLAYER_STATUS.DISCONNECTED;
    __blocked       = false;
    __ghost         = false;
    __lastInputTime = -infinity;
    
    //Set the last connected gamepad speculatively based on the platform / gamepad ban setting
    if (INPUT_BAN_GAMEPADS)
    {
        __lastConnectedGamepadType = INPUT_GAMEPAD_TYPE_NO_GAMEPAD;
    }
    else if (INPUT_ON_SWITCH)
    {
        __lastConnectedGamepadType = INPUT_GAMEPAD_TYPE_SWITCH;
    }
    else if (INPUT_ON_PS4)
    {
        __lastConnectedGamepadType = INPUT_GAMEPAD_TYPE_PS4;
    }
    else if (INPUT_ON_PS5)
    {
        __lastConnectedGamepadType = INPUT_GAMEPAD_TYPE_PS5;
    }
    else if (INPUT_ON_XBOX)
    {
        __lastConnectedGamepadType = INPUT_GAMEPAD_TYPE_XBOX;
    }
    else
    {
        __lastConnectedGamepadType = INPUT_GAMEPAD_TYPE_XBOX;
    }
    
    __kbmBindingArray = array_create_ext(_verbCount, function(_index)
    {
        static _verbArray = __InputSystem().__verbDefinitionArray;
        return variable_clone(_verbArray[_index].__kbmBinding);
    });
    
    __gamepadBindingArray = array_create_ext(_verbCount, function(_index)
    {
        static _verbArray = __InputSystem().__verbDefinitionArray;
        return variable_clone(_verbArray[_index].__gamepadBinding);
    });
    
    __verbStateArray = array_create_ext(_verbCount, function(_index)
    {
        return new __InputClassVerbState(_index);
    });
    
    __valueRawArray   = array_create(_verbCount, 0);
    __valueClampArray = array_create(_verbCount, 0);
    
    __clusterXArray = array_create(_clusterCount, 0);
    __clusterYArray = array_create(_clusterCount, 0);
    
    __consumedArray = [];
    
    
    
    static __UpdateStatus = function()
    {
        var _connected = __ghost || InputDeviceIsConnected(__device);
        
        if (_connected)
        {
            if ((__status == INPUT_PLAYER_STATUS.NEWLY_DISCONNECTED) || (__status == INPUT_PLAYER_STATUS.DISCONNECTED))
            {
                __status = INPUT_PLAYER_STATUS.NEWLY_CONNECTED;
                if (InputDeviceIsGamepad(__device)) __lastConnectedGamepadType = InputDeviceGetGamepadType(__device);
            }
            else
            {
                __status = INPUT_PLAYER_STATUS.CONNECTED;
            }
        }
        else
        {
            if ((__status == INPUT_PLAYER_STATUS.NEWLY_CONNECTED) || (__status == INPUT_PLAYER_STATUS.CONNECTED))
            {
                __status = INPUT_PLAYER_STATUS.NEWLY_DISCONNECTED;
            }
            else
            {
                __status = INPUT_PLAYER_STATUS.DISCONNECTED;
            }
        }
        
        return _connected;
    }
    
    static __Collect = function()
    {
        var _device = __device;
        
        var _connected = __UpdateStatus();
        
        var _valueRawArray   = __valueRawArray;
        var _valueClampArray = __valueClampArray;
        
        if ((not _connected) || __blocked || __ghost || InputDeviceGetRebinding(_device))
        {
            array_map_ext(_valueRawArray,   function() { return 0; });
            array_map_ext(_valueClampArray, function() { return 0; });
        }
        else
        {
            if ((_device == INPUT_TOUCH) || (INPUT_MOUSE_CAN_USE_VIRTUAL_BUTTONS && (_device == INPUT_KBM)))
            {
                //Detect any new touch points and find the top-most button to handle it
                var _i = 0;
                repeat(INPUT_MAX_TOUCHPOINTS)
                {
                    if (device_mouse_check_button_pressed(_i, mb_left))
                    {
                        var _j = 0;
                        repeat(array_length(_virtualButtonArray))
                        {
                            if (_virtualButtonArray[_j].__CaptureTouchpoint(_i)) break;
                            ++_j;
                        }
                    }
                    
                    ++_i;
                }
            }
            
            if (_device >= 0)
            {
                ////////////////
                //            //
                //  Gamepads  //
                //            //
                ////////////////
                
                var _readArray = __InputGamepadGetReadArray(_device);
                
                var _bindingArray = __gamepadBindingArray;
                var _i = 0;
                repeat(_verbCount)
                {
                    var _valueRaw   = 0;
                    var _valueClamp = 0;
                    
                    //Iterate over all our bindings to see if any buttons/axes are being held down
                    var _alternateArray = _bindingArray[_i];
                    var _j = 0;
                    repeat(array_length(_alternateArray))
                    {
                        var _rawBinding = _alternateArray[_j];
                        if (_rawBinding != undefined)
                        {
                            var _absBinding = abs(_rawBinding);
                            var _raw = max(0, sign(_rawBinding)*_readArray[_absBinding - INPUT_GAMEPAD_BINDING_MIN](_device, _absBinding));
                            if (_raw > _valueRaw)
                            {
                                _valueRaw = _raw;
                                
                                if ((_absBinding == gp_shoulderlb) || (_absBinding == gp_shoulderrb))
                                {
                                    _valueClamp = clamp((_raw - INPUT_GAMEPAD_TRIGGER_MIN_THRESHOLD) / (INPUT_GAMEPAD_TRIGGER_MAX_THRESHOLD - INPUT_GAMEPAD_TRIGGER_MIN_THRESHOLD), 0, 1);
                                }
                                else
                                {
                                    _valueClamp = clamp((_raw - INPUT_GAMEPAD_THUMBSTICK_MIN_THRESHOLD) / (INPUT_GAMEPAD_THUMBSTICK_MAX_THRESHOLD - INPUT_GAMEPAD_THUMBSTICK_MIN_THRESHOLD), 0, 1);
                                }
                            }
                        }
                        
                        ++_j;
                    }
                    
                    _valueRawArray[  _i] = _valueRaw;
                    _valueClampArray[_i] = _valueClamp;
                
                    ++_i;
                }
            }
            else if (_device == INPUT_KBM)
            {
                ////////////////////////
                //                    //
                //  Keyboard & Mouse  //
                //                    //
                ////////////////////////
                
                var _bindingArray = __kbmBindingArray;
                
                if (INPUT_MOUSE_CAN_USE_VIRTUAL_BUTTONS)
                {
                    //Reset values for each verb. We'll handle pressed/held/released after updating virtual buttons
                    array_map_ext(_valueClampArray, function() { return 0; });
                    array_map_ext(_valueRawArray,   function() { return 0; });
                    
                    //Update virtual buttons
                    var _i = 0;
                    repeat(array_length(_virtualButtonArray))
                    {
                        _virtualButtonArray[_i].__Collect(_valueRawArray, _valueClampArray);
                        ++_i;
                    }
                    
                    var _i = 0;
                    repeat(_verbCount)
                    {
                        //Iterate over all our bindings to see if any keys are being held down
                        var _newHeld = false;
                        
                        var _alternateArray = _bindingArray[_i];
                        var _j = 0;
                        repeat(array_length(_alternateArray))
                        {
                            var _binding = _alternateArray[_j];
                            if (_binding != undefined)
                            {
                                if ((_binding == mb_left)
                                    || (_binding == mb_middle)
                                    || (_binding == mb_right)
                                    || (_binding == mb_side1)
                                    || (_binding == mb_side2))
                                {
                                    if (mouse_check_button(_binding)) _newHeld = true;
                                }
                                else if (_binding == mb_wheel_up)
                                {
                                    if (mouse_wheel_up()) _newHeld = true;
                                }
                                else if (_binding == mb_wheel_down)
                                {
                                    if (mouse_wheel_down()) _newHeld = true;
                                }
                                else
                                {
                                    if (keyboard_check(_binding)) _newHeld = true;
                                }
                            }
                            
                            ++_j;
                        }
                        
                        if (_newHeld)
                        {
                            _valueRawArray[  _i] = 1;
                            _valueClampArray[_i] = 1;
                        }
                        
                        ++_i;
                    }
                }
                else
                {
                    var _i = 0;
                    repeat(_verbCount)
                    {
                        //Iterate over all our bindings to see if any keys are being held down
                        var _newHeld = false;
                        
                        var _alternateArray = _bindingArray[_i];
                        var _j = 0;
                        repeat(array_length(_alternateArray))
                        {
                            var _binding = _alternateArray[_j];
                            if (_binding != undefined)
                            {
                                if ((_binding == mb_left)
                                ||  (_binding == mb_middle)
                                ||  (_binding == mb_right)
                                ||  (_binding == mb_side1)
                                ||  (_binding == mb_side2))
                                {
                                    if (mouse_check_button(_binding)) _newHeld = true;
                                }
                                else if (_binding == mb_wheel_up)
                                {
                                    if (mouse_wheel_up()) _newHeld = true;
                                }
                                else if (_binding == mb_wheel_down)
                                {
                                    if (mouse_wheel_down()) _newHeld = true;
                                }
                                else
                                {
                                    if (keyboard_check(_binding)) _newHeld = true;
                                }
                            }
                            
                            ++_j;
                        }
                        
                        if (_newHeld)
                        {
                            _valueRawArray[  _i] = 1;
                            _valueClampArray[_i] = 1;
                        }
                        else
                        {
                            _valueRawArray[  _i] = 0;
                            _valueClampArray[_i] = 0;
                        }
                        
                        ++_i;
                    }
                }
            }
            else if (_device == INPUT_TOUCH)
            {
                ///////////////////
                //               //
                //  Touchscreen  //
                //               //
                ///////////////////
                
                //Reset values for each verb. We'll handle pressed/held/released after updating virtual buttons
                array_map_ext(_valueClampArray, function() { return 0; });
                array_map_ext(_valueRawArray,   function() { return 0; });
                
                //Update virtual buttons
                var _i = 0;
                repeat(array_length(_virtualButtonArray))
                {
                    _virtualButtonArray[_i].__Collect(_valueRawArray, _valueClampArray);
                    ++_i;
                }
            }
        }
        
        //Give plug-ins the opportunity to fiddle with verb state before consumption and clusters
        __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.COLLECT_PLAYER, __playerIndex);
    }
    
    static __Update = function()
    {
        var _systemFrame      = _system.__frame;
        var _anyHardwareInput = false;
        
        var _verbStateArray  = __verbStateArray;
        var _valueRawArray   = __valueRawArray;
        var _valueClampArray = __valueClampArray;
        
        //Give plug-ins the opportunity to fiddle with verb state before consumption and clusters
        __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER, __playerIndex);
        
        /////////////////////////
        //                     //
        //  Verb State Update  //
        //                     //
        /////////////////////////
                
        //Detect pressed/held/released state based on values that the virtual button has outputted
        var _i = 0;
        repeat(_verbCount)
        {
            with(_verbStateArray[_i])
            {
                __prevHeld = __held;
                
                __valueRaw   = _valueRawArray[_i];
                __valueClamp = _valueClampArray[_i];
                
                if (__valueClamp > 0)
                {
                    _anyHardwareInput = true;
                    
                    __held = true;
                    if (not __prevHeld) __pressFrame = _systemFrame;
                }
                else
                {
                    __held = false;
                }
            }
            
            ++_i;
        }
        
        //////////////////////
        //                  //
        //  Consumed Verbs  //
        //                  //
        //////////////////////
        
        var _consumedArray = __consumedArray;
        var _i = 0;
        repeat(array_length(_consumedArray))
        {
            with(_consumedArray[_i])
            {
                if (__held)
                {
                    __held       = false;
                    __valueRaw   = 0;
                    __valueClamp = 0;
                    __pressFrame = -infinity;
                    
                    ++_i;
                }
                else
                {
                    array_delete(_consumedArray, _i, 1);
                }
            }
        }
        
        ////////////////
        //            //
        //  Clusters  //
        //            //
        ////////////////
        
        var _i = 0;
        repeat(_clusterCount)
        {
            var _clusterDefinition = _clusterDefinitionArray[_i];
            
            //Pull raw verb values so we can apply thresholds in 2D
            var _valueU = _verbStateArray[_clusterDefinition.__verbUp   ].__valueRaw;
            var _valueR = _verbStateArray[_clusterDefinition.__verbRight].__valueRaw;
            var _valueD = _verbStateArray[_clusterDefinition.__verbDown ].__valueRaw;
            var _valueL = _verbStateArray[_clusterDefinition.__verbLeft ].__valueRaw;
            
            //Calculate the actual raw x/y values
            var _dx = _valueR - _valueL;
            var _dy = _valueD - _valueU;
            
            //Calculate the displacement
            var _d = sqrt(_dx*_dx + _dy*_dy);
            
            //If the displacement is exactly zero then skip then early-out
            if (_d <= 0.0)
            {
                __clusterXArray[_i] = 0;
                __clusterYArray[_i] = 0;
            }
            else
            {
                //Scale down the x/y values so we can clamp output values between 0 and 1
                _dx /= max(1, _d);
                _dy /= max(1, _d);
                _d = min(1, _d);
                
                var _coeff = clamp((_d - INPUT_GAMEPAD_THUMBSTICK_MIN_THRESHOLD) / (INPUT_GAMEPAD_THUMBSTICK_MAX_THRESHOLD - INPUT_GAMEPAD_THUMBSTICK_MIN_THRESHOLD), 0.0, 1.0);
                _dx *= _coeff;
                _dy *= _coeff;
                
                if (INPUT_2D_XY_AXIS_BIAS > 0)
                {
                    var _divisor = INPUT_2D_XY_AXIS_BIAS_DIAGONALS? 45 : 90;
                    
                    var _direction = point_direction(0, 0, _dx, _dy);
                    var _dirMod = (_direction mod _divisor) / _divisor;
                    _dirMod = clamp((_dirMod - 0.5*0.999*INPUT_2D_XY_AXIS_BIAS) / (1 - 0.999*INPUT_2D_XY_AXIS_BIAS), 0, 1);
                    _dirMod = _dirMod*_dirMod*(3 - 2*_dirMod); //Smooth step babyyyy
                    _direction = _divisor*((_direction div _divisor) + _dirMod);
                    
                    var _distance = point_distance(0, 0, _dx, _dy);
                    _dx = lengthdir_x(_distance, _direction);
                    _dy = lengthdir_y(_distance, _direction);
                }
                
                //Spit out the answer!
                __clusterXArray[_i] = _dx;
                __clusterYArray[_i] = _dy;
            }
            
            ++_i;
        }
        
        if (_anyHardwareInput) __lastInputTime = current_time;
    }
}