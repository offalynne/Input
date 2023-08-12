// Feather disable all
function __input_class_vibration_pulse(_strength, _pan, _repeats, _duration, _force) constructor
{
    __force = _force;
    
    __output_left  = 0;
    __output_right = 0;
    
    __strength_left  = _strength*clamp(1 - _pan, 0, 1);
    __strength_right = _strength*clamp(1 + _pan, 0, 1);
    __repeats        = _repeats;
    
    __time     = 0;
    __duration = _duration;
    
    static __tick = function(_time_step)
    {
        __time += _time_step;
        
        var _t = __time / __duration;
        var _output = 0.5 + 0.5*dsin(_t*(360*__repeats - 180));
        __output_left  = _output*__strength_left;
        __output_right = _output*__strength_right;
        
        return (__time < __duration);
    }
}
