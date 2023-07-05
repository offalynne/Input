function __InputClassBindingMouse() : __InputClassBindingCommon() constructor
{
    static __source     = INPUT_MOUSE;
    static __sourceType = __INPUT_SOURCE.MOUSE;
    
    static __Set = function(_constant, _playerSet = false)
    {
        __constant = _constant;
        __RefreshLabel();
    }
    
    static __Read = function(_player, _verbState, _hasKeyboard, _hasMouse, _hasGamepad, _mixedMode)
    {
        if (_hasMouse && input_mouse_check(__constant))
        {
            with(_verbState)
            {
                __value        = 1.0;
                __raw          = 1.0;
                __analogue     = false;
                __raw_analogue = false;
            }
            
            return true;
        }
        
        return false;
    }
    
    static __Duplicate = function()
    {
        with(new __InputClassBindingMouse())
        {
            __constant = other.__constant;
            __label    = other.__label;
            
            return self;
        }
    }
    
    static __Export = function()
    {
        return {
            bind: __InputConstantToLabel(__constant),
        };
    }
    
    static __Import = function(_struct)
    {
        if (not variable_struct_exists(_struct, "bind"))
        {
            __input_error("Mouse binding not found");
        }
        
        var _label    = _struct[$ "bind"];
        var _constant = __InputLabelToConstant(_label);
        
        if (!is_numeric(_constant))
        {
            __input_error("Mouse binding \"", _label, "\" not supported");
        }
        
        var _sourceType = __InputConstantToSourceType(_constant);
        if (_sourceType != __sourceType)
        {
            __input_error("Binding \"", _label, "\" is not a mouse binding");
        }
        
        __Set(_constant, false, false);
    }
}