function __InputClassBindingMouseButton() constructor
{
    static __type   = "mouse button";
    static __source = INPUT_MOUSE;
    
    __constant = undefined;
    
    static __Set = function(_constant, _negative = false, _playerSet = false)
    {
        __constant = _constant;
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
}