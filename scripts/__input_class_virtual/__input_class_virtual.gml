function __input_class_virtual() constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE  //Set static __global
    
    array_push(__global.__virtual_array, self);
    __global.__virtual_order_dirty = true;
    
    
    
    __destroyed  = false;
    __background = false;
    
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
    __start_x  = undefined;
    __start_y  = undefined;
    
    __type       = INPUT_VIRTUAL_TYPE.BUTTON;
    __verb_click = undefined;
    __verb_left  = undefined;
    __verb_right = undefined;
    __verb_up    = undefined;
    __verb_down  = undefined;
    
    __4dir = false;
    
    __threshold_min = INPUT_VIRTUAL_BUTTON_MIN_THRESHOLD;
    __threshold_max = INPUT_VIRTUAL_BUTTON_MAX_THRESHOLD;
    
    __release_behavior = INPUT_VIRTUAL_RELEASE.DO_NOTHING;
    __active           = true;
    __priority         = 0;
    __follow           = false;
    __record_history   = false;
    __first_touch_only = false;
    
    //State
    //These variables should be cleared by .__clear_state()
    __touch_device        = undefined;
    __pressed             = false;
    __held                = false;
    __released            = false;
    __normalized_x        = 0;
    __normalized_y        = 0;
    __touch_x             = undefined;
    __touch_y             = undefined;
    __touch_start_x       = undefined;
    __touch_start_y       = undefined;
    __history_array       = undefined; //Created when setting history recording
    __history_count       = 0;
    __captured_this_frame = false;
    
    
    
    
    static destroy = function()
    {
        __destroyed = true;
        __global.__virtual_order_dirty = true;
        
        return undefined;
    }
    
    static debug_draw = function()
    {
        if (__destroyed || __background) return;
        
        if (__active && is_struct(__global.__touch_player))
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
                draw_rectangle(__left+8, __top+8, __right-8, __bottom-8, !__held);
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
    
    static rectangle = function(_in_left, _in_top, _in_right, _in_bottom)
    {
        if (__destroyed || __background) return self;
        
        _left   = min(_in_left, _in_right);
        _top    = min(_in_top, _in_bottom);
        _right  = max(_in_left, _in_right);
        _bottom = max(_in_top, _in_bottom);
        
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
        
        __start_x = __x;
        __start_y = __y;
        
        return self;
    }
    
    static circle = function(_x, _y, _radius)
    {
        if (__destroyed || __background) return self;
        
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
        
        __start_x = __x;
        __start_y = __y;
        
        return self;
    }
    
    static get_position = function()
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
    
    static button = function(_verb)
    {
        if (__destroyed || __background) return self;
        
        __type       = INPUT_VIRTUAL_TYPE.BUTTON;
        __verb_click = _verb;
        __verb_left  = undefined;
        __verb_right = undefined;
        __verb_up    = undefined;
        __verb_down  = undefined;
        
        return self;
    }
    
    static dpad = function(_click, _left, _right, _up, _down, _4dir = false)
    {
        if (__destroyed || __background) return self;
        
        __type       = _4dir? INPUT_VIRTUAL_TYPE.DPAD_4DIR : INPUT_VIRTUAL_TYPE.DPAD_8DIR;
        __verb_click = _click;
        __verb_left  = _left;
        __verb_right = _right;
        __verb_up    = _up;
        __verb_down  = _down;
        
        return self;
    }
    
    static thumbstick = function(_click, _left, _right, _up, _down)
    {
        if (__destroyed || __background) return self;
        
        __type       = INPUT_VIRTUAL_TYPE.THUMBSTICK;
        __verb_click = _click;
        __verb_left  = _left;
        __verb_right = _right;
        __verb_up    = _up;
        __verb_down  = _down;
        
        return self;
    }
    
    static get_type = function()
    {
        return __type;
    }
    
    static get_verbs = function()
    {
        static _struct = {
            click: undefined,
            left:  undefined,
            right: undefined,
            up:    undefined,
            down:  undefined,
        };
        
        _struct.click = __verb_click;
        _struct.left  = __verb_left;
        _struct.right = __verb_right;
        _struct.up    = __verb_up;
        _struct.down  = __verb_down;
        
        return _struct;
    }
    
    static threshold = function(_min, _max)
    {
        if (__destroyed) return self;
        
        __threshold_min = _min;
        __threshold_max = _max;
        
        return self;
    }
    
    static get_threshold = function()
    {
        static _struct = {
            mini: undefined,
            maxi: undefined,
        };
        
        _struct.mini = __threshold_min;
        _struct.maxi = __threshold_max;
        
        return _struct;
    }
    
    static active = function(_state)
    {
        if (__destroyed) return self;
        
        //Clear state when deactivating
        if (!_state && __active) __clear_state();
        
        __active = _state;
        
        return self;
    }
    
    static get_active = function()
    {
        return __active;
    }
    
    static priority = function(_priority)
    {
        if (__destroyed) return self;
        
        if (__priority != _priority)
        {
            __priority = _priority;
            __global.__virtual_order_dirty = true;
        }
        
        return self;
    }
    
    static get_priority = function()
    {
        return __priority;
    }
    
    static follow = function(_state)
    {
        if (__destroyed) return self;
        
        __follow = _state;
        
        return self;
    }
    
    static get_follow = function()
    {
        return __follow;
    }
    
    static release_behavior = function(_option)
    {
        __release_behavior = _option;
        
        return self;
    }
    
    static get_release_behavior = function()
    {
        return __release_behavior;
    }
    
    static first_touch_only = function(_state)
    {
        //If this button has captured 
        if (_state && (__touch_device > 0)) __clear_state();
        
        __first_touch_only = _state;
        
        return self;
    }
    
    static get_first_touch_only = function()
    {
        return __first_touch_only;
    }
    
    #endregion
    
    
    
    #region Getters
    
    static pressed = function()
    {
        if (__destroyed) return false;
        
        return __pressed;
    }
    
    static check = function()
    {
        if (__destroyed) return false;
        
        return __held;
    }
    
    static released = function()
    {
        if (__destroyed) return false;
        
        return __released;
    }
    
    static get_x = function()
    {
        if (__destroyed) return 0;
        
        return __normalized_x;
    }
    
    static get_y = function()
    {
        if (__destroyed) return 0;
        
        return __normalized_y;
    }
    
    static get_touch_x = function()
    {
        if (__destroyed) return undefined;
        
        return __touch_x;
    }
    
    static get_touch_y = function()
    {
        if (__destroyed) return undefined;
        
        return __touch_y;
    }
    
    static get_touch_start_x = function()
    {
        if (__destroyed) return undefined;
        
        return __touch_start_x;
    }
    
    static get_touch_start_y = function()
    {
        if (__destroyed) return undefined;
        
        return __touch_start_y;
    }
    
    #endregion
    
    
    
    #region History
    
    static record_history = function(_state)
    {
        if (__destroyed) return undefined;
        
        __record_history = _state;
        
        //If we've changed the history record state
        if (__record_history != is_array(__history_array))
        {
            if (__record_history)
            {
                __history_array = array_create(INPUT_TOUCH_HISTORY_FRAMES+1, undefined);
                __history_count = 0;
                
                //Assign lots of memory because we're evil >:)
                var _i = 0;
                repeat(INPUT_TOUCH_HISTORY_FRAMES+1)
                {
                    __history_array[@ _i] = {
                        x: undefined,
                        y: undefined,
                    };
                    
                    ++_i;
                }
            }
            else
            {
                //Free memory because we're well-behaved programmers O:)
                __history_array = undefined;
                __history_count = 0;
            }
        }
        
        return self;
    }
    
    static get_history = function()
    {
        if (__destroyed) return undefined;
        
        return __history_array;
    }
    
    static get_history_direction = function(_frames = INPUT_TOUCH_HISTORY_FRAMES)
    {
        if (__destroyed) return undefined;
        
        if (_frames <= 0)
        {
            __input_error("Number of sampling frames must be 1 or greater");
            return undefined;
        }
        
        if (_frames > INPUT_TOUCH_HISTORY_FRAMES)
        {
            __input_error("Number of sampling frames (", _frames, ") cannot exceed INPUT_TOUCH_HISTORY_FRAMES (", INPUT_TOUCH_HISTORY_FRAMES, ")");
            return undefined;
        }
        
        //Limit the history collection to the number of frames that we've recorded
        _frames = min(__history_count-1, _frames, INPUT_TOUCH_HISTORY_FRAMES);
        if (_frames <= 0) return 0;
        
        var _point0 = __history_array[0];
        var _pointN = __history_array[_frames];
        return point_direction(_pointN.x, _pointN.y, _point0.x, _point0.y);
    }
    
    static get_history_distance = function(_frames = INPUT_TOUCH_HISTORY_FRAMES)
    {
        if (__destroyed) return undefined;
        
        if (_frames <= 0)
        {
            __input_error("Number of sampling frames must be 1 or greater");
            return undefined;
        }
        
        if (_frames > INPUT_TOUCH_HISTORY_FRAMES)
        {
            __input_error("Number of sampling frames (", _frames, ") cannot exceed INPUT_TOUCH_HISTORY_FRAMES (", INPUT_TOUCH_HISTORY_FRAMES, ")");
            return undefined;
        }
        
        //Limit the history collection to the number of frames that we've recorded
        _frames = min(__history_count-1, _frames, INPUT_TOUCH_HISTORY_FRAMES);
        if (_frames <= 0) return 0;
        
        var _distance = 0;
        
        var _x1 = undefined;
        var _y1 = undefined;
        var _point = __history_array[0];
        var _x2 = _point.x;
        var _y2 = _point.y;
        
        var _i = 1;
        repeat(_frames)
        {
            _x1 = _x2;
            _y1 = _y2;
            var _point = __history_array[_i];
            var _x2 = _point.x;
            var _y2 = _point.y;
            
            var _dX = _x2 - _x1;
            var _dY = _y2 - _y1;
            _distance += sqrt(_dX*_dX + _dY*_dY);
            
            ++_i;
        }
        
        return _distance;
    }
    
    static get_history_speed = function(_frames = INPUT_TOUCH_HISTORY_FRAMES)
    {
        if (__destroyed) return undefined;
        
        //Limit the history collection to the number of frames that we've recorded
        _frames = min(__history_count-1, _frames, INPUT_TOUCH_HISTORY_FRAMES);
        if (_frames <= 0) return 0;
        
        return get_history_distance(_frames) / _frames;
    }
    
    #endregion
    
    
    
    #region Private
    
    static __set_as_background = function()
    {
        rectangle(0, 0, max(display_get_width(), display_get_height()), max(display_get_width(), display_get_height()));
        __priority = -infinity;
        __background = true;
        return self;
    }
    
    static __clear_state = function()
    {
        __touch_device = undefined;
        
        __pressed  = false;
        __held     = false;
        __released = false;
            
        //Clear touch position variables
        __normalized_x  = 0;
        __normalized_y  = 0;
        __touch_x       = undefined;
        __touch_y       = undefined;
        __touch_start_x = undefined;
        __touch_start_y = undefined;
        
        //Clear out the history array
        if (__record_history)
        {
            __history_count = 0;
            
            var _i = 0;
            repeat(INPUT_TOUCH_HISTORY_FRAMES+1)
            {
                with(__history_array[@ _i])
                {
                    x = undefined;
                    y = undefined;
                };
                
                ++_i;
            }
        }
        
        if (__release_behavior == INPUT_VIRTUAL_RELEASE.RESET_POSITION)
        {
            if ((__start_x != undefined) && (__start_y != undefined))
            {
                var _dx = __start_x - __x;
                var _dy = __start_y - __y;
                
                __left   += _dx;
                __top    += _dy;
                __right  += _dx;
                __bottom += _dy;
                
                __x = __start_x;
                __y = __start_y;
            }
        }
        else if (__release_behavior == INPUT_VIRTUAL_RELEASE.DESTROY)
        {
            destroy();
        }
    }
    
    static __capture_touchpoint = function(_device)
    {
        if (__touch_device != undefined) return false;
        if (__circular == undefined) return false;
        if (!__active) return false;
        if (__first_touch_only && (_device > 0)) return false;
        
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
            __touch_start_x = _touch_x;
            __touch_start_y = _touch_y;
            
            if (__record_history) __history_push(_touch_x, _touch_y);
            
            //We set further variables in the __tick method()
            
            __touch_device = _device;
            __captured_this_frame = true;
        }
        
        return _over;
    }
    
    static __tick = function()
    {
        if (__destroyed) return undefined;
        if (__touch_device == undefined) return undefined;
        
        if (__released)
        {
            __clear_state();
            
            //Nope out if we were destroyed on release
            if (__destroyed) return undefined;
        }
        
        if (__captured_this_frame)
        {
            __captured_this_frame = false;
            
            __pressed  = true;
            __held     = true;
            __released = false;
        }
        else
        {
            __pressed  = false;
            __released = false;
        }
        
        if (__held)
        {
            if (not device_mouse_check_button(__touch_device, mb_left))
            {
                __pressed  = false;
                __held     = false;
                __released = true;
            }
            else
            {
                var _player = __global.__touch_player;
                _player.__verb_set_from_virtual(__verb_click, 1, 1, false);
                
                __touch_x = device_mouse_x_to_gui(__touch_device);
                __touch_y = device_mouse_y_to_gui(__touch_device);
                
                if (__record_history) __history_push(__touch_x, __touch_y);
                
                var _dx = __touch_x - __x;
                var _dy = __touch_y - __y;
                
                var _length = _dx*_dx + _dy*_dy;
                if (_length <= 0)
                {
                    //We don't like div-by-zero
                    var _threshold_factor = 0;
                    __normalized_x = 0;
                    __normalized_y = 0;
                }
                else
                {
                    var _length = sqrt(_length);
                    var _threshold_factor = clamp((_length - __threshold_min) / (__threshold_max - __threshold_min), 0, 1) / _length;
                    __normalized_x = _threshold_factor*_dx;
                    __normalized_y = _threshold_factor*_dy;
                    
                    if (__follow)
                    {
                        var _move_x = 0;
                        var _move_y = 0;
                        
                        if (__circular == true)
                        {
                            var _move_distance = max(0, _length - __radius);
                            _move_x = _move_distance*_dx / _length;
                            _move_y = _move_distance*_dy / _length;
                        }
                        else if (__circular == false)
                        {
                            var _dLeft   = min(0, __touch_x - __left  );
                            var _dTop    = min(0, __touch_y - __top   );
                            var _dRight  = max(0, __touch_x - __right );
                            var _dBottom = max(0, __touch_y - __bottom);
                            
                            _move_x += _dLeft + _dRight;
                            _move_y += _dTop  + _dBottom;
                        }
                        
                        __x      += _move_x;
                        __y      += _move_y;
                        __left   += _move_x;
                        __top    += _move_y;
                        __right  += _move_x;
                        __bottom += _move_y;
                    }
                }
                
                if (_threshold_factor > 0)
                {
                    if (__type == INPUT_VIRTUAL_TYPE.DPAD_4DIR)
                    {
                        var _direction = floor((point_direction(0, 0, __normalized_x, __normalized_y) + 45) / 90) mod 4;
                        switch(_direction)
                        {
                            case 0:
                                _player.__verb_set_from_virtual(__verb_right, 1, 1, false);
                            break;
                            
                            case 1:
                                _player.__verb_set_from_virtual(__verb_up, 1, 1, false);
                            break;
                            
                            case 2:
                                _player.__verb_set_from_virtual(__verb_left, 1, 1, false);
                            break;
                            
                            case 3:
                                _player.__verb_set_from_virtual(__verb_down, 1, 1, false);
                            break;
                        }
                    }
                    else
                    {
                        var _direction = floor((point_direction(0, 0, __normalized_x, __normalized_y) + 22.5) / 45) mod 8;
                        
                        if (__type == INPUT_VIRTUAL_TYPE.DPAD_8DIR)
                        {
                            switch(_direction)
                            {
                                case 0:
                                case 1:
                                case 7:
                                    _player.__verb_set_from_virtual(__verb_right, 1, 1, false);
                                break;
                                
                                case 3:
                                case 4:
                                case 5:
                                    _player.__verb_set_from_virtual(__verb_left, 1, 1, false);
                                break;
                            }
                            
                            switch(_direction)
                            {
                                case 1:
                                case 2:
                                case 3:
                                    _player.__verb_set_from_virtual(__verb_up, 1, 1, false);
                                break;
                                
                                case 5:
                                case 6:
                                case 7:
                                    _player.__verb_set_from_virtual(__verb_down, 1, 1, false);
                                break;
                            }
                        }
                        else if (__type == INPUT_VIRTUAL_TYPE.THUMBSTICK)
                        {
                            var _clamped_x = sign(_dx)*clamp((abs(_dx) - __threshold_min) / (__threshold_max - __threshold_min), 0, 1);
                            var _clamped_y = sign(_dy)*clamp((abs(_dy) - __threshold_min) / (__threshold_max - __threshold_min), 0, 1);
                            
                            switch(_direction)
                            {
                                case 0:
                                case 1:
                                case 7:
                                    _player.__verb_set_from_virtual(__verb_right, max(0, _dx), max(0, _clamped_x), true);
                                break;
                                
                                case 3:
                                case 4:
                                case 5:
                                    _player.__verb_set_from_virtual(__verb_left, max(0, -_dx), max(0, -_clamped_x), true);
                                break;
                            }
                            
                            switch(_direction)
                            {
                                case 1:
                                case 2:
                                case 3:
                                    _player.__verb_set_from_virtual(__verb_up, max(0, -_dy), max(0, -_clamped_y), true);
                                break;
                                
                                case 5:
                                case 6:
                                case 7:
                                    _player.__verb_set_from_virtual(__verb_down, max(0, _dy), max(0, _clamped_y), true);
                                break;
                            }
                        }
                    }
                }
            }
        }
    }
    
    static __history_push = function(_x, _y)
    {
        //Cycle the history array and add a new entry using the previous touch x/y coordinate
        var _last_coord = __history_array[@ INPUT_TOUCH_HISTORY_FRAMES];
        _last_coord.x = _x;
        _last_coord.y = _y;
        
        array_delete(__history_array, INPUT_TOUCH_HISTORY_FRAMES, 1);
        array_insert(__history_array, 0, _last_coord);
        
        ++__history_count;
    }
    
    #endregion
}
