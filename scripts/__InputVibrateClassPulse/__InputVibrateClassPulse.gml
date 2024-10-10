// Feather disable all

function __InputVibrateClassPulse(_strength, _pan, _repeats, _duration, _force) constructor
{
    __force = _force;
    
    __outputLeft  = 0;
    __outputRight = 0;
    
    __strengthLeft  = _strength*clamp(1 - _pan, 0, 1);
    __strengthRight = _strength*clamp(1 + _pan, 0, 1);
    __repeats      = _repeats;
    
    __time     = 0;
    __duration = _duration;
    
    static __Update = function()
    {
        __time += delta_time/1000;
        
        var _t = __time / __duration;
        var _output = 0.5 + 0.5*dsin(_t*(360*__repeats - 180));
        __outputLeft  = _output*__strengthLeft;
        __outputRight = _output*__strengthRight;
        
        return (__time < __duration);
    }
}
