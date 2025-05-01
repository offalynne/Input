// Feather disable all

/// @param playerIndex

function __InputClassPlayer(_playerIndex) constructor
{
    static _system                 = __InputSystem();
    static _verbCount              = _system.__verbCount;
    static _clusterCount           = _system.__clusterCount;
    static _clusterDefinitionArray = _system.__clusterDefinitionArray;
    
    __playerIndex = _playerIndex;
    
    __device           = INPUT_NO_DEVICE;
    __metadata         = undefined;
    __status           = INPUT_PLAYER_STATUS.DISCONNECTED;
    __blocked          = false;
    __ghost            = false;
    __anyHardwareInput = false;
    __lastInputTime    = -infinity;
    
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
    
    __verbMetadataArray = array_create_ext(_verbCount, function(_index)
    {
        static _verbDefinitionArray = __InputSystem().__verbDefinitionArray;
        return variable_clone(_verbDefinitionArray[_index].__metadata);
    });
    
    __clusterMetadataArray = array_create_ext(_clusterCount, function(_index)
    {
        static _clusterDefinitionArray = __InputSystem().__clusterDefinitionArray;
        return variable_clone(_clusterDefinitionArray[_index].__metadata);
    });
    
    __valueRawArray   = array_create(_verbCount, 0);
    __valueClampArray = array_create(_verbCount, 0);
    
    __clusterXArray = array_create(_clusterCount, 0);
    __clusterYArray = array_create(_clusterCount, 0);
    __clusterThresholdTypeArray = array_create(_verbCount, INPUT_THRESHOLD.LEFT);
    
    __thresholdMinArray = array_create(INPUT_THRESHOLD.__SIZE, INPUT_GAMEPAD_THUMBSTICK_MIN_THRESHOLD);
    __thresholdMaxArray = array_create(INPUT_THRESHOLD.__SIZE, INPUT_GAMEPAD_THUMBSTICK_MAX_THRESHOLD);
    
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
    
    static __UpdateClusterThresholds = function()
    {
        static _funcUpdateThresholdType = function(_alternateArray)
        {
            var _thresholdType = 0;
            
            var _alternate = 0;
            repeat(array_length(_alternateArray))
            {
                var _binding = _alternateArray[_alternate];
                
                if (_binding != undefined)
                {
                    _binding = abs(_binding);
                    _thresholdType |= ((_binding == gp_axislh) || (_binding == gp_axislv))? 1 : (((_binding == gp_axisrh) || (_binding == gp_axisrv))? 2 : 0);
                }
                
                ++_alternate;
            }
            
            return _thresholdType;
        }
        
        var _gamepadBindingArray = __gamepadBindingArray;
        var _clusterThresholdTypeArray = __clusterThresholdTypeArray;
        
        var _cluster = 0;
        repeat(_clusterCount)
        {
            var _clusterDefinition = _clusterDefinitionArray[_cluster];
            
            var _thresholdType = 0;
            _thresholdType |= _funcUpdateThresholdType(_gamepadBindingArray[_clusterDefinition.__verbUp   ]);
            _thresholdType |= _funcUpdateThresholdType(_gamepadBindingArray[_clusterDefinition.__verbRight]);
            _thresholdType |= _funcUpdateThresholdType(_gamepadBindingArray[_clusterDefinition.__verbDown ]);
            _thresholdType |= _funcUpdateThresholdType(_gamepadBindingArray[_clusterDefinition.__verbLeft ]);
            
            if (_thresholdType <= 1) //Default to .LEFT if none of the bindings are thumbsticks
            {
                _clusterThresholdTypeArray[@ _cluster] = INPUT_THRESHOLD.LEFT;
            }
            else if (_thresholdType == 2)
            {
                _clusterThresholdTypeArray[@ _cluster] = INPUT_THRESHOLD.RIGHT;
            }
            else
            {
                _clusterThresholdTypeArray[@ _cluster] = INPUT_THRESHOLD.BOTH;
            }
            
            ++_cluster;
        }
    }
    
    static __Update = function()
    {
        /////////////////////////
        //                     //
        //  Verb State Update  //
        //                     //
        /////////////////////////
        
        __anyHardwareInput = false;
        __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER, __playerIndex);
        
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
        
        var _verbStateArray  = __verbStateArray;
        
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
                __clusterXArray[@ _i] = 0;
                __clusterYArray[@ _i] = 0;
            }
            else
            {
                //Scale down the x/y values so we can clamp output values between 0 and 1
                _dx /= max(1, _d);
                _dy /= max(1, _d);
                _d = min(1, _d);
                
                //If we're using a gamepad, apply thumbstick thresholds to the cluster. This ignores whether the
                //player has actually used a thumbstick for input so is potentially problematic in unanticipated
                //use cases.
                if (__device >= 0)
                {
                    var _thresholdType = __clusterThresholdTypeArray[_i];
                    
                    var _a = __thresholdMinArray[_thresholdType];
                    var _b = __thresholdMaxArray[_thresholdType];
                    
                    var _min = clamp(min(_a, _b), 0, 1);
                    var _max = clamp(max(_a, _b), 0, 1);
                    
                    var _delta = _max - _min;
                    if (_delta == 0) _delta = 0.001;
                    
                    var _coeff = clamp((_d - _min) / _delta, 0.0, 1.0);
                    _dx = (_dx/_d)*_coeff;
                    _dy = (_dy/_d)*_coeff;
                }
                
                var _bias = _clusterDefinition.__axisBiasFactor;
                if (_bias > 0)
                {
                    var _divisor = _clusterDefinition.__axisBiasDiagonals? 45 : 90;
                    var _direction = point_direction(0, 0, _dx, _dy);
                    
                    if (_bias >= 1)
                    {
                        _direction = _divisor*round(_direction/_divisor);
                    }
                    else
                    {
                        var _dirMod = (_direction mod _divisor) / _divisor;
                        _dirMod = clamp((_dirMod - 0.5*0.999*_bias) / (1 - 0.999*_bias), 0, 1);
                        _dirMod = _dirMod*_dirMod*(3 - 2*_dirMod); //Smooth step babyyyy
                        _direction = _divisor*((_direction div _divisor) + _dirMod);
                    }
                    
                    var _distance = point_distance(0, 0, _dx, _dy);
                    _dx = lengthdir_x(_distance, _direction);
                    _dy = lengthdir_y(_distance, _direction);
                }
                
                //Spit out the answer!
                __clusterXArray[@ _i] = _dx;
                __clusterYArray[@ _i] = _dy;
            }
            
            ++_i;
        }
        
        if (__anyHardwareInput) __lastInputTime = current_time;
    }
}