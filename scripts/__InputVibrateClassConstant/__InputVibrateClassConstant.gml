// Feather disable all

/// @param strength
/// @param pan
/// @param duration
/// @param force

function __InputVibrateClassConstant(_strength, _pan, _duration, _force) constructor
{
    __force = _force;
    
    __outputLeft  = _strength*clamp(1 - _pan, 0, 1);
    __outputRight = _strength*clamp(1 + _pan, 0, 1);
    
    __time     = 0;
    __duration = _duration;
    
    static __Update = function()
    {
        __time += delta_time/1000;
        return (__time < __duration);
    }
}