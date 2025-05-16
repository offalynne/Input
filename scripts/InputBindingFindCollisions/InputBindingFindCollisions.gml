// Feather disable all

/// Returns all verbs (and alternate slots) that would collide with the provided binding if it were
/// set for the target verb index and alternate slot. This function returns an array of structs. If
/// the array is empty then no collisions were found. The structs contain two values:
/// 
/// - `.verbIndex`  The verb using the binding
/// - `.alternate`  The alternate slot, for that verb, using the binding
/// 
/// @param {Bool} forGamepad
/// @param {Any} binding
/// @param {Enum.INPUT_VERB,Real} verbIndex
/// @param {Real} [playerIndex=0]
/// @param {Real} [alternate=0]

function InputBindingFindCollisions(_forGamepad, _binding, _verbIndex, _playerIndex = 0, _alternate = 0)
{
    static _array = [];
    array_resize(_array, 0);
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.FIND_BINDING_COLLISIONS, _array, _forGamepad, _binding, _verbIndex, _alternate, _playerIndex);
    
    return _array;
}