// Feather disable all

/// Vibrates a player's gampead over an Attack-Decay-Sustain-Release curve. Time units are in
/// milliseconds. Set the `force argument to `true` to force the vibration to happen regardless
/// of whether the player has gamepad vibration paused.
///          
/// @param {Real} peakStrength
/// @param {Real} sustainLevel
/// @param {Real} pan
/// @param {Real} attackTime
/// @param {Real} decayTime
/// @param {Real} sustainTime
/// @param {Real} releaseTime
/// @param {Real} [playerIndex=0]
/// @param {Boolean} [force=false]

function InputVibrateADSR(_peakStrength, _sustainLevel, _pan, _attack, _decay, _sustain, _release, _playerIndex = 0, _force = false)
{
    static _playerArray = __InputVibrateSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    _peakStrength = clamp(_peakStrength, 0, 1);
    _sustainLevel = clamp(_sustainLevel, 0, 1);
    _pan          = clamp(_pan, -1, 1);
    _attack       = max(_attack, 0);
    _decay        = max(_decay, 0);
    _sustain      = max(_sustain, 0);
    _release      = max(_release, 0);
    
    with(_playerArray[_playerIndex])
    {
        if ((not __paused) || _force)
        {
            array_push(__eventArray, new __InputVibrateClassADSR(_peakStrength, _sustainLevel, _pan, _attack, _decay, _sustain, _release, _force));
        }
    }
}
