// Feather disable all

/// @param playerIndex

function __InputTriggerEffectPlayer(_playerIndex) constructor
{
    static _deviceMap = __InputTriggerEffectSystem().__deviceMap;
    
    __playerIndex = _playerIndex;
    
    __paused           = false;
    __strength         = INPUT_TRIGGER_EFFECT_DEFAULT_STRENGTH;
    __interceptedLeft  = false;
    __interceptedRight = false;
    __effectLeft       = new __InputTriggerEffectClassOff();
    __effectRight      = new __InputTriggerEffectClassOff();
    
    
    
    static __SetTriggerEffect = function(_trigger, _effect, _set)
    {
        var _device = InputPlayerGetDevice(__playerIndex);
        
        //Ignore anything that's not a gamepad
        if (_device < 0) return;
        
        if (__paused)
        {
            __InputTrace("Warning! New trigger effect ignored, player ", __playerIndex, " trigger effect is paused");
            return;
        }
        
        //Apply the effect and get the interception outcome
        var _struct = _deviceMap[? _device];
        if (not is_struct(_struct))
        {
            __InputTrace($"Warning! Device {_device} is not registered with the trigger effect handler");
            return;
        }
        
        var _intercepted = (_struct.__Apply(_trigger, _effect, __strength) == false);
        
        if (!_set) return;
        
        if (_trigger == gp_shoulderlb)
        {
            __interceptedLeft = _intercepted;
            __effectLeft      = _effect;
        }
        else if (_trigger == gp_shoulderrb)
        {
            __interceptedRight = _intercepted;
            __effectRight      = _effect;                 
        }
        else
        {
            __InputError("Value ", _trigger ," not a gamepad trigger");
            return false;
        }
    }
    
    static __SetPause = function(_state)
    {
        __paused = _state;
        
        if (_state)
        {
            __InputTriggerEffectStop(InputPlayerGetDevice(__playerIndex));
        }
        else
        {
            __InputTriggerEffectReapply(__playerIndex);
        }
    }
}