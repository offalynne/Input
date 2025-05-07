// Feather disable all

/// @param [playerIndex=0]

function InputCursorElasticGet(_playerIndex = 0)
{
    static _playerArray = __InputCursorSystem().__playerArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    static _result = {
        enabled: false,
        x: 0,
        y: 0,
        strength: 0,
    };
    
    with(_playerArray[_playerIndex])
    {
        _result.enabled  = ((__elasticX != undefined) && (__elasticY != undefined));
        _result.x        = __elasticX
        _result.y        = __elasticY;
        _result.strength = __elasticStrength;
    }
    
    return _result;
}