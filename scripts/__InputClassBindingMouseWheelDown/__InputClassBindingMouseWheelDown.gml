function __InputClassBindingMouseWheelDown() constructor
{
    static __type   = "mouse wheel down";
    static __source = INPUT_MOUSE;
    
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
}