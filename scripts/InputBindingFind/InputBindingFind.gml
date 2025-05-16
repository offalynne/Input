// Feather disable all

/// Returns all verbs (and alternate slots) that use the specified binding. This function returns
/// an array of structs. If the array is empty then no verbs that use the binding were found. The
/// structs contain two values:
/// 
/// - `.verbIndex`  The verb using the binding
/// - `.alternate`  The alternate slot, for that verb, using the binding
/// 
/// @param {Bool} forGamepad
/// @param {Any} binding
/// @param {Real} [playerIndex=0]

function InputBindingFind(_forGamepad, _binding, _playerIndex = 0)
{
    static _array = [];
    array_resize(_array, 0);
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    //We use an abstracted function here to allow us to reuse the core logic inside the
    //`.FIND_BINDING_COLLISIONS` callback
    __InputBindingFindInternal(_array, _forGamepad, _binding, _playerIndex);
    
    return _array;
}

function __InputBindingFindInternal(_array, _forGamepad, _binding, _playerIndex)
{
    static _playerArray = __InputSystemPlayerArray();
    static _verbCount   = __InputSystem().__verbCount;
    
    with(_playerArray[_playerIndex])
    {
        var _bindingArray = _forGamepad? __gamepadBindingArray : __kbmBindingArray;
        
        var _verbIndex = 0;
        repeat(_verbCount)
        {
            var _alternateArray = _bindingArray[_verbIndex];
            var _alternate = 0;
            repeat(array_length(_alternateArray))
            {
                if (_alternateArray[_alternate] == _binding)
                {
                    array_push(_array, {
                        verbIndex: _verbIndex,
                        alternate: _alternate,
                    });
                }
                
                ++_alternate;
            }
            
            ++_verbIndex;
        }
    }
}