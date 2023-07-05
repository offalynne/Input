function __InputClassBindingMouseButton() : __InputClassBindingCommon() constructor
{
    static __type   = __INPUT_BINDING_MOUSE_BUTTON;
    static __source = INPUT_MOUSE;
    
    static __Set = function(_constant, _negative = false, _playerSet = false)
    {
        __constant = _constant;
        __SetLabel(__constant);
    }
    
    static __Read = function(_player, _verbState)
    {
        if (_player.__sourceHasMouse && input_mouse_check(__constant))
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
    
    static toString = function()
    {
        return __label;
    }
}