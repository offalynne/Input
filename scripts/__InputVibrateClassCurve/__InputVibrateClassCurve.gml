// Feather disable all

function __InputVibrateClassCurve(_strength, _curve, _pan, _duration, _force) constructor
{
    __force = _force;
    
    __outputLeft  = 0;
    __outputRight = 0;
    
    __strengthLeft  = _strength*clamp(1 - _pan, 0, 1);
    __strengthRight = _strength*clamp(1 + _pan, 0, 1);
    __curve          = _curve;
    
    __time     = 0;
    __duration = _duration;
    
    static __Update = function()
    {
        __time += delta_time/1000;
        var _t = __time / __duration;
        
        var _count = array_length(__curve.channels);
        if (_count == 1)
        {
            __outputLeft  = clamp(animcurve_channel_evaluate(animcurve_get_channel(__curve, 0), _t), 0, 1);
            __outputRight = __outputLeft;
        }
        else
        {
            var _left  = animcurve_get_channel(__curve, animcurve_get_channel(__curve, 0));
            var _right = animcurve_get_channel(__curve, animcurve_get_channel(__curve, 1));
            
            if (_left  != -1) __outputLeft  = clamp(animcurve_channel_evaluate(_left,  _t), 0, 1);
            if (_right != -1) __outputRight = clamp(animcurve_channel_evaluate(_right, _t), 0, 1);
        }
        
        __outputLeft  *= __strengthLeft;
        __outputRight *= __strengthRight
        
        return (__time < __duration);
    }
}
