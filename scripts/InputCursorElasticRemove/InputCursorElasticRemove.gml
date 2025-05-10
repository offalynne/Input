// Feather disable all

/// Removes the elastic force on a cursor.
/// 
/// @param [playerIndex=0]

function InputCursorElasticRemove(_playerIndex = 0)
{
    static _playerArray = __InputCursorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        __elasticX        = undefined;
        __elasticY        = undefined;
        __elasticStrength = 0;
    }
}