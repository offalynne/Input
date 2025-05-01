// Feather disable all

/// Vibrates a player's gampead with a series of pulses over the given duration, measured in
/// millseconds. Set the `force argument to `true` to force the vibration to happen regardless
/// of whether the player has gamepad vibration paused.
///          
/// @param {Real} strength
/// @param {Real} pan
/// @param {Real} repeats
/// @param {Real} duration
/// @param {Real} [playerIndex=0]
/// @param {Boolean} [force=false]

function InputVibratePulse(_strength, _pan, _repeats, _duration, _playerIndex = 0, _force = false)
{
    static _playerArray = __InputVibrateSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    _strength = clamp(_strength, 0, 1);
    _pan      = clamp(_pan, -1, 1);
    _repeats  = max(_repeats, 0);
    _duration = max(_duration, 0);
    
    with(_playerArray[_playerIndex])
    {
        if ((not __paused) || _force)
        {
            array_push(__eventArray, new __InputVibrateClassPulse(_strength, _pan, _repeats, _duration, _force));
        }
    }
}
