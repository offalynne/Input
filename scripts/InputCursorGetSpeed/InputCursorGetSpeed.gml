// Feather disable all

/// Returns the speed of the player's cursor, measured in pixels per frame.
/// 
/// @param [playerIndex=0]

function InputCursorGetSpeed(_playerIndex = 0)
{
    static _playerArray = __InputCursorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    return _playerArray[_playerIndex].__speed;
}