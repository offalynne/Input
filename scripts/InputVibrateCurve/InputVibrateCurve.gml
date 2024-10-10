// Feather disable all

/// Vibrates a player's gamepad using an animation curve to control the strength. The duration of
/// playback is measured in milliseconds. If the curve has one channel, that channel controls both
/// left and right motors. If the curve has two (or more) channels then the first two channels from
/// left and right motos respectively. Set the `force argument to `true` to force the vibration to
/// happen regardless of whether the player has gamepad vibration paused.
/// 
/// @param {Real} strength
/// @param {Asset.GMAnimCurve} curve
/// @param {Real} pan
/// @param {Real} duration
/// @param {Real} [playedIndex=0]
/// @param {Boolean} [force=false]

function InputVibrateCurve(_strength, _curve, _pan, _duration, _playerIndex = 0, _force = false)
{
    static _playerArray = __InputVibrateSystem().__playerArray;
    
    _strength = clamp(_strength, 0, 1);
    if (not animcurve_exists(_curve)) __InputError("Animation curve doesn't exist (", _curve, ")");
    _pan      = clamp(_pan, -1, 1);
    _duration = max(_duration, 0);
    
    with(_playerArray[_playerIndex])
    {
        if ((not __paused) || _force)
        {
            array_push(__eventArray, new __InputVibrateClassCurve(_strength, animcurve_get(_curve), _pan, _duration, _force));
        }
    }
}
