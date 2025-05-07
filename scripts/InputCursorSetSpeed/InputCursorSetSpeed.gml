// Feather disable all

/// Sets the speed of the player's cursor, measured in pixels per frame and as such is *not*
/// inherently delta-timed. The default speed if this function is never called is set by the
/// `INPUT_CURSOR_DEFAULT_SPEED` macro. Cursor movement is further affected by an exponent factor,
/// given by the value of `INPUT_CURSOR_EXPONENT.
/// 
/// @param speed
/// @param [playerIndex=0]

function InputCursorSetSpeed(_speed, _playerIndex = 0)
{
    static _playerArray = __InputCursorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    _playerArray[_playerIndex].__speed = _speed;
}