// Feather disable all

/// Returns a binding for a player as set by `InputBindingSet()` or `InputDefineVerb()`.
/// 
/// N.B. For left and up bindings on thumbsticks, the returned value will be negative.
/// 
/// @param {Bool} forGamepad
/// @param {Enum.INPUT_VERB,Real} verbIndex
/// @param {Real} [alternate=0]
/// @param {Real} [playerIndex=0]

function InputBindingGet(_forGamepad, _verbIndex, _alternate = 0, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    with(_playerArray[_playerIndex])
    {
        var _bindingArray = _forGamepad? __gamepadBindingArray : __kbmBindingArray;
        var _alternateArray = _bindingArray[_verbIndex];
        
        if ((_alternate < 0) || (_alternate >= array_length(_alternateArray))) return undefined;
        return _alternateArray[_alternate];
    }
}