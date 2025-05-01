// Feather disable all

/// Sets whether a player's input should be blocked. Blocked players will have all their verb
/// values forcibly set to zero, beginning at the start of the next frame. If the player is holding
/// any buttons down at the moment that their input is blocked, release events will be triggered
/// for all of those held buttons.
/// 
/// @param {Bool} state
/// @param {Real} [playerIndex=0]

function InputPlayerSetBlocked(_state, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    _playerArray[_playerIndex].__blocked = _state;
}