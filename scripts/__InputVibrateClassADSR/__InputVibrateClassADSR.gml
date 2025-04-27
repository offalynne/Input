// Feather disable all

function __InputVibrateClassADSR(_peakStrength, _sustainLevel, _pan, _attack, _decay, _sustain, _release, _force) constructor
{
    __force = _force;
    
    __outputLeft  = 0;
    __outputRight = 0;
    
    __strengthLeft  = _peakStrength*clamp(1 - _pan, 0, 1);
    __strengthRight = _peakStrength*clamp(1 + _pan, 0, 1);
    __sustainLevel  = _sustainLevel;
    __pan           = _pan;
    
    __attack  = _attack;
    __decay   = _decay;
    __sustain = _sustain;
    __release = _release;
    
    __phase       = 0;
    __timeInPhase = 0;
    
    static __Update = function()
    {
        var _timeStep = delta_time/1000;
        
        __timeInPhase += _timeStep;
        
        var _min        = 0;
        var _max        = 0;
        var _phase_time = infinity;
        switch(__phase)
        {
            case 0: //Attack
                _min        = 0;
                _max        = 1;
                _phase_time = __attack;
            break;
            
            case 1: //Decay
                _min        = 1;
                _max        = __sustainLevel;
                _phase_time = __decay;
            break;
            
            case 2: //Sustain
                _min        = __sustainLevel;
                _max        = __sustainLevel;
                _phase_time = __sustain;
            break;
            
            case 3: //Release
                _min        = __sustainLevel;
                _max        = 0;
                _phase_time = __release;
            break;
        }
        
        var _output = lerp(_min, _max, clamp(__timeInPhase / _phase_time, 0, 1));
        __outputLeft  = _output*__strengthLeft;
        __outputRight = _output*__strengthRight;
        
        __timeInPhase += _timeStep;
        if (__timeInPhase > _phase_time)
        {
            __timeInPhase -= _phase_time;
            ++__phase;
        }
        
        return (__phase <= 3);
    }
}