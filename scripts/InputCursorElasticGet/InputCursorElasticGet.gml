// Feather disable all

/// Returns the elastic properties for the player's cursor as a struct. The returned struct
/// contains the following member variables:
/// 
/// - `.enabled`
/// - `.x`
/// - `.y`
/// - `.strength`
/// 
/// N.B. If no elastic state has been set, `.enabled` will be `false` and the other member
///      variables will be set to `undefined`. 
/// 
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