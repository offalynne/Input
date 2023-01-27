function __input_class_virtual() constructor
{
    array_push(global.__input_virtual_array, weak_ref_create(self));
    global.__input_virtual_priority_dirty = true;
    
    
    
    __destroyed  = false;
    __background = false;
    __captured_this_frame = false;
    
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
    
    __type       = INPUT_VIRTUAL_TYPE.BUTTON;
    __verb_click = undefined;
    __verb_left  = undefined;
    __verb_right = undefined;
    __verb_up    = undefined;
    __verb_down  = undefined;
    
    __threshold_min = INPUT_VIRTUAL_BUTTON_MIN_THRESHOLD;
    __threshold_max = INPUT_VIRTUAL_BUTTON_MAX_THRESHOLD;
    
    __release_behaviour = INPUT_VIRTUAL_RELEASE.DO_NOTHING;
    __active            = true;
    __player_index      = 0;
    __priority          = 0;
    __follow            = false;
    __record_history    = false;
    __history_array     = undefined; //Created when setting history recording
    
    __touch_device  = undefined;
    __pressed       = false;
    __held          = false;
    __released      = false;
    __normalized_x  = 0;
    __normalized_y  = 0;
    __touch_x       = undefined;
    __touch_y       = undefined;
    __touch_start_x = undefined;
    __touch_start_y = undefined;
    
    
    
    
    static destroy = function()
    {
        __destroyed = true;
        
        return undefined;
    }
    
    
    
    #region Setup
    
    static rectangle = function(_left, _top, _right, _bottom)
    {
        if (__destroyed || __background) return self;
        
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
    
    static button = function(_click_verb)
    {
        if (__destroyed || __background) return self;
        
        __type       = INPUT_VIRTUAL_TYPE.BUTTON;
        __verb_click = _click_verb;
        __verb_left  = undefined;
        __verb_right = undefined;
        __verb_up    = undefined;
        __verb_down  = undefined;
        
        return self;
    }
    
    static dpad = function(_click_verb, _left_verb, _right_verb, _up_verb, _down_verb)
    {
        if (__destroyed || __background) return self;
        
        __type       = INPUT_VIRTUAL_TYPE.DPAD;
        __verb_click = _click_verb;
        __verb_left  = _left_verb;
        __verb_right = _right_verb;
        __verb_up    = _up_verb;
        __verb_down  = _down_verb;
        
        return self;
    }
    
    static thumbstick = function(_click_verb, _left_verb, _right_verb, _up_verb, _down_verb)
    {
        if (__destroyed || __background) return self;
        
        __type       = INPUT_VIRTUAL_TYPE.THUMBSTICK;
        __verb_click = _click_verb;
        __verb_left  = _left_verb;
        __verb_right = _right_verb;
        __verb_up    = _up_verb;
        __verb_down  = _down_verb;
        
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
        
        __active = _state;
        
        return self;
    }
    
    static get_active = function()
    {
        return __active;
    }
    
    static player = function(_player_index)
    {
        if (__destroyed) return self;
        
        __player_index = _player_index;
        
        return self;
    }
    
    static get_player = function()
    {
        return __player_index;
    }
    
    static priority = function(_priority)
    {
        if (__destroyed) return self;
        
        if (__priority != _priority)
        {
            __priority = _priority;
            global.__input_virtual_priority_dirty = true;
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
        
        if (__record_history != is_array(__history_array))
        {
            if (__record_history)
            {
                __history_array = array_create(INPUT_TOUCH_HISTORY_FRAMES, undefined);
                
                //Assign lots of memory because we're evil >:)
                var _i = 0;
                repeat(INPUT_TOUCH_HISTORY_FRAMES)
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
        
        __input_error("This features has not yet been implement");
        
        return undefined;
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
        
        __input_error("This features has not yet been implement");
        
        return undefined;
    }
    
    static get_history_speed = function(_frames = INPUT_TOUCH_HISTORY_FRAMES)
    {
        if (__destroyed) return undefined;
        
        return get_history_distance(_frames) / _frames;
    }
    
    #endregion
    
    
    
    #region Private
    
    static __capture_touchpoint = function(_device)
    {
        if (__touch_device != undefined) return false;
        if (__circular == undefined) return false;
        
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
            //We set __touch_x/__touch_y in the __tick method()
            __touch_start_x = _touch_x;
            __touch_start_y = _touch_y;
            
            __touch_device = _device;
            __captured_this_frame = true;
            
            __pressed  = true;
            __held     = true;
            __released = false;
        }
        
        return _over;
    }
    
    static __tick = function()
    {
        if (__destroyed) return undefined;
        if (__touch_device == undefined) return undefined;
        
        if (__released)
        {
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
                var _i = 0;
                repeat(INPUT_TOUCH_HISTORY_FRAMES)
                {
                    with(__history_array[@ _i])
                    {
                        x = undefined;
                        y = undefined;
                    };
                    
                    ++_i;
                }
            }
        }
        
        if (__captured_this_frame)
        {
            __captured_this_frame = false;
        }
        else
        {
            __pressed = false;
            
            if (__held)
            {
                if (device_mouse_check_button(__touch_device, mb_left))
                {
                    if (__record_history)
                    {
                        //Cycle the history array and add a new entry using the previous touch x/y coordinate
                        var _last_coord = __history_array[@ INPUT_TOUCH_HISTORY_FRAMES-1];
                        _last_coord.x = __touch_x;
                        _last_coord.y = __touch_y;
                        
                        array_delete(__history_array, INPUT_TOUCH_HISTORY_FRAMES-1, 1);
                        array_insert(__history_array, _last_coord);
                    }
                    
                    __touch_x = device_mouse_x_to_gui(__touch_device);
                    __touch_y = device_mouse_y_to_gui(__touch_device);
                    
                    var _dx = __touch_x - __x;
                    var _dy = __touch_y - __y;
                    
                    var _length = _dx*_dx + _dy*_dy;
                    if (_length <= 0)
                    {
                        //We don't like div-by-zero
                        __normalized_x = 0;
                        __normalized_y = 0;
                    }
                    else
                    {
                        var _length = sqrt(_length);
                        var _factor = clamp((_length - __threshold_min) / (__threshold_max - __threshold_min), 0, 1) / _length;
                        __normalized_x = _factor*_dx;
                        __normalized_y = _factor*_dy;
                    }
                }
                else
                {
                    __touch_device = undefined;
                    
                    __held     = false;
                    __released = true;
                }
            }
        }
    }
    
    static __debug_draw = function()
    {
        if (__destroyed) return;
        
        if (__circular == true)
        {
            draw_circle(__x, __y, __radius, true);
            if (__held) draw_circle(__x, __y, __radius-8, false);
        }
        else if (__circular == false)
        {
            draw_rectangle(__left, __top, __right, __bottom, true);
            if (__held) draw_rectangle(__left+4, __top+4, __right-4, __bottom-4, false);
        }
    }
    
    #endregion
}