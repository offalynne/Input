// Feather disable all
function __InputClassVirtualButton() constructor
{
    static _system = __InputSystem();
    
    array_push(_system.__virtualButtonArray, self);
    
    
    //_system.__virtualOrderDirty = true;
    
    
    
    __destroyed = false;
    
    __circular = undefined;
    __left     = undefined;
    __top      = undefined;
    __right    = undefined;
    __bottom   = undefined;
    __width    = undefined;
    __height   = undefined;
    __x        = undefined;
    __y        = undefined;
    __radius   = undefined;
    __startX   = undefined;
    __startY   = undefined;
    __prevX   = undefined;
    __prevY   = undefined;
    
    __type      = INPUT_VIRTUAL_TYPE.BUTTON;
    __reference = INPUT_VIRTUAL_REFERENCE.CENTER;
    __verbClick = undefined;
    __verbLeft  = undefined;
    __verbRight = undefined;
    __verbUp    = undefined;
    __verbDown  = undefined;
    
    __thresholdMin = INPUT_VIRTUAL_BUTTON_MIN_THRESHOLD;
    __thresholdMax = INPUT_VIRTUAL_BUTTON_MAX_THRESHOLD;
    
    __releaseBehavior = INPUT_VIRTUAL_RELEASE.DO_NOTHING;
    __active          = true;
    __priority        = 0;
    __follow          = false;
    __recordHistory   = false;
    __firstTouchOnly  = false;
    __momentary       = false;
    
    //State
    //These variables should be cleared by .__ClearState()
    __touchDevice  = undefined;
    __prevHeld     = false;
    __held         = false;
    __heldBuffer   = false;
    __normalizedX  = 0;
    __normalizedY  = 0;
    __touchX       = undefined;
    __touchY       = undefined;
    __touchStartX  = undefined;
    __touchStartY  = undefined;
    __historyArray = undefined; //Created when setting history recording
    __historyCount = 0;
    __captureFrame = undefined;
    
    
    
    
    static Destroy = function()
    {
        __destroyed = true;
        _system.__virtualOrderDirty = true;
        
        return undefined;
    }
    
    static DebugDraw = function()
    {
        if (__destroyed) return;
        
        if (__active)
        {
            if (__circular == true)
            {
                draw_circle(__x, __y, __radius,   true);
                draw_circle(__x, __y, __radius-4, true);
                draw_circle(__x, __y, __radius-8, !__held);
            }
            else if (__circular == false)
            {
                draw_rectangle(__left,   __top,   __right,   __bottom,   true);
                draw_rectangle(__left+4, __top+4, __right-4, __bottom-4, true);
            }
            
            if (__type == INPUT_VIRTUAL_TYPE.BUTTON)
            {
                if (__circular == true)
                {
                    draw_circle(__x, __y, __radius-8, !__held);
                }
                else if (__circular == false)
                {
                    draw_rectangle(__left+8, __top+8, __right-8, __bottom-8, !__held);
                }
            }
            else
            {
                var _x = 0.5*(__left + __right);
                var _y = 0.5*(__top + __bottom);
                var _radius = 0.5*(min(__right - __left, __bottom - __top) - 8);
                draw_circle(_x, _y, _radius,   true);
                draw_circle(_x, _y, _radius-1, true);
                draw_circle(_x, _y, _radius-2, true);
                draw_circle(_x, _y, _radius-3, true);
                draw_circle(_x, _y, _radius,   false);
                
                var _centre = InputXY(__verbLeft, __verbRight, __verbUp, __verbDown);
                draw_circle(_x + _radius*_centre.x, _y + _radius*_centre.y, 0.25*_radius, false);
            }
        }
        else
        {
            var _old_alpha = draw_get_alpha();
            draw_set_alpha(0.33*_old_alpha);
            
            if (__circular == true)
            {
                draw_circle(__x, __y, __radius, true);
            }
            else if (__circular == false)
            {
                draw_rectangle(__left, __top, __right, __bottom, true);
            }
            
            draw_set_alpha(_old_alpha);
        }
    }
    
    
    
    #region Setup
    
    static Rectangle = function(_in_left, _in_top, _in_right, _in_bottom)
    {
        if (__destroyed) return self;
        
        var _left   = min(_in_left, _in_right);
        var _top    = min(_in_top, _in_bottom);
        var _right  = max(_in_left, _in_right);
        var _bottom = max(_in_top, _in_bottom);
        
        __circular = false;
        __left     = _left;
        __top      = _top;
        __right    = _right;
        __bottom   = _bottom;
        __width    = 1 + _right - _left;
        __height   = 1 + _bottom - _top;
        __x        = 0.5*(_left + _right);
        __y        = 0.5*(_bottom + _top);
        __radius   = undefined;
        
        __startX = __x;
        __startY = __y;
        
        return self;
    }
    
    static Circle = function(_x, _y, _radius)
    {
        if (__destroyed) return self;
        
        __circular = true;
        __left     = _x - _radius;
        __top      = _y - _radius;
        __right    = _x + _radius;
        __bottom   = _y + _radius;
        __width    = 2*_radius;
        __height   = 2*_radius;
        __x        = _x;
        __y        = _y;
        __radius   = _radius;
        
        __startX = __x;
        __startY = __y;
        
        return self;
    }
    
    static GetPosition = function()
    {
        static _struct = {
            left:   undefined,
            top:    undefined,
            right:  undefined,
            bottom: undefined,
            width:  undefined,
            height: undefined,
            x:      undefined,
            y:      undefined,
            radius: undefined,
        };
        
        _struct.left   = __left;
        _struct.top    = __top;
        _struct.right  = __right;
        _struct.bottom = __bottom;
        _struct.width  = __width;
        _struct.height = __height;
        _struct.x      = __x;
        _struct.y      = __y;
        _struct.radius = __radius;
        
        return _struct;
    }
    
    /// @param {Enum.INPUT_VERB,Real} verb
    static Button = function(_verb)
    {
        if (__destroyed) return self;
        
        __type       = INPUT_VIRTUAL_TYPE.BUTTON;
        __verbClick = _verb;
        __verbLeft  = undefined;
        __verbRight = undefined;
        __verbUp    = undefined;
        __verbDown  = undefined;
        
        return self;
    }
    
    // Horizontal 1-axis DPAD
    static HPad = function(_click, _left, _right)
    {
        if (__destroyed) return self;
        __type       = INPUT_VIRTUAL_TYPE.DPAD_HORIZONTAL;
        __verbClick = _click;
        __verbLeft  = _left;
        __verbRight = _right;
        __verbUp    = undefined;
        __verbDown  = undefined;
        return self;
    }

    // Vertical 1-axis DPAD
    static VPad = function(_click, _up, _down)
    {
        if (__destroyed) return self;
        __type       = INPUT_VIRTUAL_TYPE.DPAD_VERTICAL;
        __verbClick = _click;
        __verbLeft  = undefined;
        __verbRight = undefined;
        __verbUp    = _up;
        __verbDown  = _down;
        return self;
    }

    static DPad = function(_click, _left, _right, _up, _down, _4dir = false)
    {
        if (__destroyed) return self;
        
        __type       = _4dir? INPUT_VIRTUAL_TYPE.DPAD_4DIR : INPUT_VIRTUAL_TYPE.DPAD_8DIR;
        __verbClick = _click;
        __verbLeft  = _left;
        __verbRight = _right;
        __verbUp    = _up;
        __verbDown  = _down;
        
        return self;
    }
    
    static Thumbstick = function(_click, _left, _right, _up, _down)
    {
        if (__destroyed) return self;
        
        __type       = INPUT_VIRTUAL_TYPE.THUMBSTICK;
        __verbClick = _click;
        __verbLeft  = _left;
        __verbRight = _right;
        __verbUp    = _up;
        __verbDown  = _down;
        
        return self;
    }
    
    static Touchpad = function(_click, _left, _right, _up, _down)
    {
        if (__destroyed) return self;
        
        __type      = INPUT_VIRTUAL_TYPE.TOUCHPAD;
        __verbClick = _click;
        __verbLeft  = _left;
        __verbRight = _right;
        __verbUp    = _up;
        __verbDown  = _down;
        
        return self;
    }
    
    static GetType = function()
    {
        return __type;
    }
    
    static GetVerbs = function()
    {
        static _struct = {
            click: undefined,
            left:  undefined,
            right: undefined,
            up:    undefined,
            down:  undefined,
        };
        
        _struct.click = __verbClick;
        _struct.left  = __verbLeft;
        _struct.right = __verbRight;
        _struct.up    = __verbUp;
        _struct.down  = __verbDown;
        
        return _struct;
    }
    
    static Threshold = function(_min, _max)
    {
        if (__destroyed) return self;
        
        __thresholdMin = _min;
        __thresholdMax = _max;
        
        return self;
    }
    
    static GetThreshold = function()
    {
        static _struct = {
            mini: undefined,
            maxi: undefined,
        };
        
        _struct.mini = __thresholdMin;
        _struct.maxi = __thresholdMax;
        
        return _struct;
    }
    
    static Active = function(_state)
    {
        if (__destroyed) return self;
        
        //Clear state when deactivating
        if (!_state && __active) __ClearState();
        
        __active = _state;
        
        return self;
    }
    
    static GetActive = function()
    {
        return __active;
    }
    
    static Priority = function(_priority)
    {
        if (__destroyed) return self;
        
        if (__priority != _priority)
        {
            __priority = _priority;
            _system.__virtualOrderDirty = true;
        }
        
        return self;
    }
    
    static GetPriority = function()
    {
        return __priority;
    }
    
    static Follow = function(_state)
    {
        if (__destroyed) return self;
        
        __follow = _state;
        
        return self;
    }
    
    static GetFollow = function()
    {
        return __follow;
    }
    
    static ReleaseBehavior = function(_option)
    {
        __releaseBehavior = _option;
        
        return self;
    }
    
    static GetReleaseBehavior = function()
    {
        return __releaseBehavior;
    }
    
    static FirstTouchOnly = function(_state)
    {
        //If this Button has captured 
        if (_state && (__touchDevice > 0)) __ClearState();
        
        __firstTouchOnly = _state;
        
        return self;
    }
    
    static GetFirstTouchOnly = function()
    {
        return __firstTouchOnly;
    }
    
    static ReferencePoint = function(_option)
    {
        __reference = _option;
        
        return self;
    }
    
    static GetReferencePoint = function()
    {
        return __reference;
    }
    
    static Momentary = function(_state)
    {
        __momentary = _state;
        
        return self;
    }
    
    static GetMomentary = function()
    {
        return __momentary;
    }
    
    #endregion
    
    
    
    #region Getters
    
    static Pressed = function()
    {
        if (__destroyed) return false;
        
        return ((not __prevHeld) && __held);
    }
    
    static Check = function()
    {
        if (__destroyed) return false;
        
        return __held;
    }
    
    static Released = function()
    {
        if (__destroyed) return false;
        
        return (__prevHeld && (not __held));
    }
    
    static GetX = function()
    {
        if (__destroyed) return 0;
        
        return __normalizedX;
    }
    
    static GetY = function()
    {
        if (__destroyed) return 0;
        
        return __normalizedY;
    }
    
    static GetTouchX = function()
    {
        if (__destroyed) return 0;
        
        return __touchX;
    }
    
    static GetTouchY = function()
    {
        if (__destroyed) return 0;
        
        return __touchY;
    }
    
    static GetTouchDX = function()
    {
        if (__destroyed) return 0;
        if (__prevX == undefined) return 0;
        
        return __touchX - __prevX;
    }
    
    static GetTouchDY = function()
    {
        if (__destroyed) return 0;
        if (__prevY == undefined) return 0;
        
        return __touchY - __prevY;
    }
    
    static GetTouchStartX = function()
    {
        if (__destroyed) return 0;
        
        return __touchStartX;
    }
    
    static GetTouchStartY = function()
    {
        if (__destroyed) return 0;
        
        return __touchStartY;
    }
    
    #endregion
    
    
    
    #region History
    
    static RecordHistory = function(_state)
    {
        if (__destroyed) return undefined;
        
        __recordHistory = _state;
        
        //If we've changed the history record state
        if (__recordHistory != is_array(__historyArray))
        {
            if (__recordHistory)
            {
                __historyArray = array_create(INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES+1, undefined);
                __historyCount = 0;
                
                //Assign lots of memory because we're evil >:)
                var _i = 0;
                repeat(INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES+1)
                {
                    __historyArray[@ _i] = {
                        x: undefined,
                        y: undefined,
                    };
                    
                    ++_i;
                }
            }
            else
            {
                //Free memory because we're well-behaved programmers O:)
                __historyArray = undefined;
                __historyCount = 0;
            }
        }
        
        return self;
    }
    
    static GetHistory = function()
    {
        if (__destroyed) return undefined;
        
        return __historyArray;
    }
    
    static GetHistoryDirection = function(_frames = INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES)
    {
        if (__destroyed) return undefined;
        
        if (_frames <= 0)
        {
            __InputError("Number of sampling frames must be 1 or greater");
            return undefined;
        }
        
        if (_frames > INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES)
        {
            __InputError("Number of sampling frames (", _frames, ") cannot exceed INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES (", INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES, ")");
            return undefined;
        }
        
        //Limit the history collection to the number of frames that we've recorded
        _frames = min(__historyCount-1, _frames, INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES);
        if (_frames <= 0) return 0;
        
        var _point0 = __historyArray[0];
        var _pointN = __historyArray[_frames];
        return point_direction(_pointN.x, _pointN.y, _point0.x, _point0.y);
    }
    
    static GetHistoryDistance = function(_frames = INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES)
    {
        if (__destroyed) return undefined;
        
        if (_frames <= 0)
        {
            __InputError("Number of sampling frames must be 1 or greater");
            return undefined;
        }
        
        if (_frames > INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES)
        {
            __InputError("Number of sampling frames (", _frames, ") cannot exceed INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES (", INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES, ")");
            return undefined;
        }
        
        //Limit the history collection to the number of frames that we've recorded
        _frames = min(__historyCount-1, _frames, INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES);
        if (_frames <= 0) return 0;
        
        var _distance = 0;
        
        var _x1 = undefined;
        var _y1 = undefined;
        var _point = __historyArray[0];
        var _x2 = _point.x;
        var _y2 = _point.y;
        
        var _i = 1;
        repeat(_frames)
        {
            _x1 = _x2;
            _y1 = _y2;
            var _point = __historyArray[_i];
            var _x2 = _point.x;
            var _y2 = _point.y;
            
            var _dX = _x2 - _x1;
            var _dY = _y2 - _y1;
            _distance += sqrt(_dX*_dX + _dY*_dY);
            
            ++_i;
        }
        
        return _distance;
    }
    
    static GetHistorySpeed = function(_frames = INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES)
    {
        if (__destroyed) return undefined;
        
        //Limit the history collection to the number of frames that we've recorded
        _frames = min(__historyCount-1, _frames, INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES);
        if (_frames <= 0) return 0;
        
        return GetHistoryDistance(_frames) / _frames;
    }
    
    #endregion
    
    
    
    #region Private
    
    static __ClearState = function()
    {
        __touchDevice = undefined;
        
        __prevHeld   = false;
        __held       = false;
        __heldBuffer = false;
            
        //Clear touch position variables
        __normalizedX  = 0;
        __normalizedY  = 0;
        __touchX       = undefined;
        __touchY       = undefined;
        __touchStartX = undefined;
        __touchStartY = undefined;
        
        //Clear out the history array
        if (__recordHistory)
        {
            __historyCount = 0;
            
            var _i = 0;
            repeat(INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES+1)
            {
                with(__historyArray[@ _i])
                {
                    x = undefined;
                    y = undefined;
                };
                
                ++_i;
            }
        }
        
        if (__releaseBehavior == INPUT_VIRTUAL_RELEASE.RESET_POSITION)
        {
            if ((__startX != undefined) && (__startY != undefined))
            {
                var _dx = __startX - __x;
                var _dy = __startY - __y;
                
                __left   += _dx;
                __top    += _dy;
                __right  += _dx;
                __bottom += _dy;
                
                __x = __startX;
                __y = __startY;
            }
        }
        else if (__releaseBehavior == INPUT_VIRTUAL_RELEASE.DESTROY)
        {
            Destroy();
        }
    }
    
    static __CaptureTouchpoint = function(_device)
    {
        if (__touchDevice != undefined) return false;
        if (__circular == undefined) return false;
        if (!__active) return false;
        if (__firstTouchOnly && (_device > 0)) return false;
        
        var _touch_x = device_mouse_x_to_gui(_device);
        var _touch_y = device_mouse_y_to_gui(_device);
        
        if (__circular)
        {
            var _over = point_in_circle(_touch_x, _touch_y, __x, __y, __radius);
        }
        else
        {
            var _over = point_in_rectangle(_touch_x, _touch_y, __left, __top, __right, __bottom);
        }
        
        if (_over)
        {
            // Initialize the starting point
            __touchStartX = _touch_x;
            __touchStartY = _touch_y;
            __touchX       = __touchStartX;
            __touchY       = __touchStartY;
            
            if (__recordHistory) __HistoryPush(_touch_x, _touch_y);
            
            //We set further variables in the __tick method()
            
            __touchDevice = _device;
            __captureFrame = _system.__frame;
        }
        
        return _over;
    }
    
    static __Collect = function(_valueRawArray, _valueClampArray)
    {
        var _touchDevice = __touchDevice;
        
        if (__destroyed || (_touchDevice == undefined))
        {
            __held = false;
            return undefined;
        }
        
        //We released last frame, clear state entirely
        if (__prevHeld && (not __held))
        {
            __ClearState();
            
            //Nope out if we were destroyed on release
            if (__destroyed) return undefined;
        }
        else
        {
            __prevHeld = __held;
        }
        
        if (__captureFrame == _system.__frame)
        {
            __held  = true;
            __prevX = device_mouse_x_to_gui(_touchDevice);
            __prevY = device_mouse_y_to_gui(_touchDevice);
        }
        
        if (not __held)
        {
            __prevX = undefined;
            __prevY = undefined;
        }
        else
        {
            if (__momentary)
            {
                var _sustain = (__captureFrame == _system.__frame);
            }
            else
            {
                var _sustain = device_mouse_check_button(_touchDevice, mb_left);          
                
                //Guard iOS dropping a sustained hold on SystemGestureGate timeout
                if (INPUT_ON_IOS)
                {
                    if (!_sustain && (_system.__frame - __captureFrame > 20))
                    {
                        __heldBuffer = not __heldBuffer;
                        if (__heldBuffer) _sustain = true;
                    }
                }
            }
            
            if (not _sustain)
            {
                __held = false;
            }
            else
            {
                if (__verbClick != undefined)
                {
                    _valueRawArray[@   __verbClick] = 1;
                    _valueClampArray[@ __verbClick] = 1;
                }
                
                __prevX = __touchX;
                __prevY = __touchY;
                
                if ((not INPUT_ON_IOS) || (not __heldBuffer))
                {
                    __touchX = device_mouse_x_to_gui(_touchDevice);
                    __touchY = device_mouse_y_to_gui(_touchDevice);
                }
                
                if (__recordHistory) __HistoryPush(__touchX, __touchY);
                
                //Force delta for touchpads
                var _reference = (__type == INPUT_VIRTUAL_TYPE.TOUCHPAD)? INPUT_VIRTUAL_REFERENCE.DELTA : __reference;
                switch(_reference)
                {
                    case INPUT_VIRTUAL_REFERENCE.CENTER:
                        var _dx = __touchX - __x;
                        var _dy = __touchY - __y;
                    break;
                    
                    case INPUT_VIRTUAL_REFERENCE.TOUCH_POINT:
                        var _dx = __touchX - __touchStartX;
                        var _dy = __touchY - __touchStartY;
                    break;
                    
                    case INPUT_VIRTUAL_REFERENCE.DELTA:
                        var _dx = __touchX - __prevX;
                        var _dy = __touchY - __prevY;
                    break;
                    
                    default:
                        __InputError("Reference point type (", __reference, ") not supported");
                    break;
                }
                
                var _length = _dx*_dx + _dy*_dy;
                if (_length <= 0)
                {
                    //We don't like div-by-zero
                    var _thresholdFactor = 0;
                    __normalizedX = 0;
                    __normalizedY = 0;
                }
                else
                {
                    var _length = sqrt(_length);
                    var _thresholdFactor = clamp((_length - __thresholdMin) / (__thresholdMax - __thresholdMin), 0, 1) / _length;
                    __normalizedX = _thresholdFactor*_dx;
                    __normalizedY = _thresholdFactor*_dy;
                    
                    if (__follow)
                    {
                        var _moveX = 0;
                        var _moveY = 0;
                        
                        if (__circular == true)
                        {
                            var _moveDistance = max(0, _length - __radius);
                            _moveX = _moveDistance*_dx / _length;
                            _moveY = _moveDistance*_dy / _length;
                        }
                        else if (__circular == false)
                        {
                            var _dLeft   = min(0, __touchX - __left  );
                            var _dTop    = min(0, __touchY - __top   );
                            var _dRight  = max(0, __touchX - __right );
                            var _dBottom = max(0, __touchY - __bottom);
                            
                            _moveX += _dLeft + _dRight;
                            _moveY += _dTop  + _dBottom;
                        }
                        
                        __x      += _moveX;
                        __y      += _moveY;
                        __left   += _moveX;
                        __top    += _moveY;
                        __right  += _moveX;
                        __bottom += _moveY;
                    }
                }
                
                if (_thresholdFactor > 0)
                {
                    switch(__type)
                    {
                        case INPUT_VIRTUAL_TYPE.DPAD_VERTICAL:
                            if ((floor((point_direction(0, 0, __normalizedX, __normalizedY)) / 180) mod 2) == 1)
                            {
                                if (__verbDown != undefined)
                                {
                                    _valueRawArray[@   __verbDown] = 1;
                                    _valueClampArray[@ __verbDown] = 1;
                                }
                            }
                            else
                            {
                                if (__verbUp != undefined)
                                {
                                    _valueRawArray[@   __verbUp] = 1;
                                    _valueClampArray[@ __verbUp] = 1;
                                }
                            }
                        break;
                        
                        case INPUT_VIRTUAL_TYPE.DPAD_HORIZONTAL:
                            if ((floor((point_direction(0, 0, __normalizedX, __normalizedY) + 270) / 180) mod 2) == 1)
                            {
                                if (__verbRight != undefined)
                                {
                                    _valueRawArray[@   __verbRight] = 1;
                                    _valueClampArray[@ __verbRight] = 1;
                                }
                            }
                            else
                            {
                                if (__verbLeft != undefined)
                                {
                                    _valueRawArray[@   __verbLeft] = 1;
                                    _valueClampArray[@ __verbLeft] = 1;
                                }
                            }
                        break;

                        case INPUT_VIRTUAL_TYPE.DPAD_4DIR:
                            //Split the input direction into 4 discrete parts
                            var _direction = floor((point_direction(0, 0, __normalizedX, __normalizedY) + 45) / 90) mod 4;
                            switch(_direction)
                            {
                                case 0:
                                    if (__verbRight != undefined)
                                    {
                                        _valueRawArray[@   __verbRight] = 1;
                                        _valueClampArray[@ __verbRight] = 1;
                                    }
                                break;
                            
                                case 1:
                                    if (__verbUp != undefined)
                                    {
                                        _valueRawArray[@   __verbUp] = 1;
                                        _valueClampArray[@ __verbUp] = 1;
                                    }
                                break;
                            
                                case 2:
                                    if (__verbLeft != undefined)
                                    {
                                        _valueRawArray[@   __verbLeft] = 1;
                                        _valueClampArray[@ __verbLeft] = 1;
                                    }
                                break;
                            
                                case 3:
                                    if (__verbDown != undefined)
                                    {
                                        _valueRawArray[@   __verbDown] = 1;
                                        _valueClampArray[@ __verbDown] = 1;
                                    }
                                break;
                            }
                        break;
                        
                        case INPUT_VIRTUAL_TYPE.DPAD_8DIR:
                            //Split the input direction into 8 discrete parts
                            var _direction = floor((point_direction(0, 0, __normalizedX, __normalizedY) + 22.5) / 45) mod 8;
                            switch(_direction)
                            {
                                case 0:
                                case 1:
                                case 7:
                                    if (__verbRight != undefined)
                                    {
                                        _valueRawArray[@   __verbRight] = 1;
                                        _valueClampArray[@ __verbRight] = 1;
                                    }
                                break;
                                
                                case 3:
                                case 4:
                                case 5:
                                    if (__verbLeft != undefined)
                                    {
                                        _valueRawArray[@   __verbLeft] = 1;
                                        _valueClampArray[@ __verbLeft] = 1;
                                    }
                                break;
                            }
                            
                            switch(_direction)
                            {
                                case 1:
                                case 2:
                                case 3:
                                    if (__verbUp != undefined)
                                    {
                                        _valueRawArray[@   __verbUp] = 1;
                                        _valueClampArray[@ __verbUp] = 1;
                                    }
                                break;
                                
                                case 5:
                                case 6:
                                case 7:
                                    if (__verbDown != undefined)
                                    {
                                        _valueRawArray[@   __verbDown] = 1;
                                        _valueClampArray[@ __verbDown] = 1;
                                    }
                                break;
                            }
                        break;
                        
                        case INPUT_VIRTUAL_TYPE.THUMBSTICK:
                            //Emulate the way normal thumbsticks work by clamping each axis individually
                            var _clampedX = sign(_dx)*clamp((abs(_dx) - __thresholdMin) / (__thresholdMax - __thresholdMin), 0, 1);
                            var _clampedY = sign(_dy)*clamp((abs(_dy) - __thresholdMin) / (__thresholdMax - __thresholdMin), 0, 1);
                            
                            if (__verbLeft != undefined)
                            {
                                _valueRawArray[@   __verbLeft] = max(0, -_dx);
                                _valueClampArray[@ __verbLeft] = max(0, -_clampedX);
                            }
                            
                            if (__verbUp != undefined)
                            {
                                _valueRawArray[@   __verbUp] = max(0, -_dy);
                                _valueClampArray[@ __verbUp] = max(0, -_clampedY);
                            }
                            
                            if (__verbRight != undefined)
                            {
                                _valueRawArray[@   __verbRight] = max(0, _dx);
                                _valueClampArray[@ __verbRight] = max(0, _clampedX);
                            }
                            
                            if (__verbDown != undefined)
                            {
                                _valueRawArray[@   __verbDown] = max(0, _dy);
                                _valueClampArray[@ __verbDown] = max(0, _clampedY);
                            }
                        break;
                        
                        case INPUT_VIRTUAL_TYPE.TOUCHPAD:
                            //Just pass those values straight through, YOLO
                            
                            if (__verbLeft != undefined)
                            {
                                _valueRawArray[@   __verbLeft] = max(0, -__normalizedX);
                                _valueClampArray[@ __verbLeft] = max(0, -__normalizedX);
                            }
                            
                            if (__verbUp != undefined)
                            {
                                _valueRawArray[@   __verbUp] = max(0, -__normalizedY);
                                _valueClampArray[@ __verbUp] = max(0, -__normalizedY);
                            }
                            
                            if (__verbRight != undefined)
                            {
                                _valueRawArray[@   __verbRight] = max(0, __normalizedX);
                                _valueClampArray[@ __verbRight] = max(0, __normalizedX);
                            }
                            
                            if (__verbDown != undefined)
                            {
                                _valueRawArray[@   __verbDown] = max(0, __normalizedY);
                                _valueClampArray[@ __verbDown] = max(0, __normalizedY);
                            }
                        break;
                    }
                }
            }
        }
    }
    
    static __HistoryPush = function(_x, _y)
    {
        //Cycle the history array and add a new entry using the previous touch x/y coordinate
        var _lastCoord = __historyArray[@ INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES];
        _lastCoord.x = _x;
        _lastCoord.y = _y;
        
        array_delete(__historyArray, INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES, 1);
        array_insert(__historyArray, 0, _lastCoord);
        
        ++__historyCount;
    }
    
    #endregion
}
