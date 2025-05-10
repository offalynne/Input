// Feather disable all

/// Sets up a springy force that pulls the cursor towards the given point. This is useful for
/// building aiming systems for shooters and works especially well with `InputCursorLimitCircle()`.
/// The x/y position for the center of the force is in the primary coordinate space, as given by
/// `INPUT_CURSOR_PRIMARY_COORD_SPACE`. The `strength` parameter should be a value greater than `0`
/// and less than `1`.
/// 
/// If `moveCursor` is set to `true` then the cursor will be moved by the same amount that the
/// center of the elastic force has moved. Again, this is convenient for shoots where the elastic
/// force is typically centered on the player and moving the elastic force would also typically
/// need to move the cursor by the same amount.
///
/// @param x
/// @param y
/// @param strength
/// @param [playerIndex=0]
/// @param [moveCursor=true]

function InputCursorElasticSet(_x, _y, _strength, _playerIndex = 0, _moveCursor = true)
{
    static _playerArray = __InputCursorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        if (_moveCursor && (__elasticX != undefined) && (__elasticY != undefined))
        {
            __x += __elasticX - _x;
            __y += __elasticY - _y;
        }
        
        __elasticX        = _x;
        __elasticY        = _y;
        __elasticStrength = _strength;
    }
}