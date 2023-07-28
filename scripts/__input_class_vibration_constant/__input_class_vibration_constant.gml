// Feather disable all
function __input_class_vibration_constant(_strength, _pan, _duration, _force) constructor
{
    __force = _force;
    
    __output_left  = _strength*clamp(1 - _pan, 0, 1);
    __output_right = _strength*clamp(1 + _pan, 0, 1);
    
    __time     = 0;
    __duration = _duration;
    
    static __tick = function(_time_step)
    {
        __time += _time_step;
        return (__time < __duration);
    }
}
