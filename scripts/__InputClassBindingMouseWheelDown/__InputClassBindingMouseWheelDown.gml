function __InputClassBindingMouseWheelDown() : __InputClassBindingCommon() constructor
{
    static __type   = __INPUT_BINDING_MOUSE_WHEEL_DOWN;
    static __source = INPUT_MOUSE;
    
    __SetLabel(mb_wheel_down);
    
    static __Set = function(_constant, _negative = false, _playerSet = false)
    {
    }
    
    static __Read = function(_player, _verbState)
    {
        if (_player.__sourceHasMouse && input_mouse_wheel_down())
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