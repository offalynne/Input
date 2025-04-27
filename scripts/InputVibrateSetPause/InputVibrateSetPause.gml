// Feather disable all

/// Sets the vibration pause state for a player. The constant INPUT_ALL_PLAYERS can be used
/// to target all players.
/// 
/// @param {Boolean} state
/// @param {Real} [playedIndex=0]

function InputVibrateSetPause(_state, _playerIndex = 0)
{
    static _playerArray = __InputVibrateSystem().__playerArray;
    
    if (_playerIndex == INPUT_ALL_PLAYERS)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            InputVibrateSetPause(_state, _i);
            ++_i;
        }
        
        return;
    }
    
    _playerArray[_playerIndex].__paused = _state;
}