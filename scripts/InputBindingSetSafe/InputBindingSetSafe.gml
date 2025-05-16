// Feather disable all

/// Sets a binding for a player, overwriting the binding that was already there. If `forGamepad`
/// is specified, the binding will be set for gamepad devices, otherwise the binding will be set
/// for the keyboard and mouse device (`INPUT_KBM`). The alternate index parameter can be used
/// to set multiple parallel bindings for one verb.
/// 
/// This function, unlike `InputBindingSet()`, will try to automatically resolve conflicts. This
/// function is effective for simple control schemes but may fail in more complex situations; in
/// these cases, you’ll need to handle conflict resolution yourself.
/// 
/// @param {Bool} forGamepad
/// @param {Enum.INPUT_VERB,Real} verbIndex
/// @param {Any} binding
/// @param {Real} [alternate=0]
/// @param {Real} [playerIndex=0]

function InputBindingSetSafe(_forGamepad, _verbIndexA, _binding, _alternateA = 0, _playerIndex = 0)
{
    __INPUT_VALIDATE_PLAYER_INDEX
    
    var _collisionArray = InputBindingFindCollisions(_forGamepad, _binding, _verbIndexA, _playerIndex, _alternateA);
    
    if (array_length(_collisionArray) == 0)
    {
        InputBindingSet(_forGamepad, _verbIndexA, _binding, _alternateA, _playerIndex);
        return true;
    }
    else
    {
        if (array_length(_collisionArray) > 1)
        {
            __InputTrace("Warning! More than one binding collision found, resolution may not be desirable");
        }
            
        var _verbIndexB = _collisionArray[0].verbIndex;
        var _alternateB = _collisionArray[0].alternate;
            
        if ((_verbIndexA != _verbIndexB) || (_alternateA != _alternateB))
        {
            __InputTrace("Collision found in (forGamepad=", _forGamepad, ", verb=", InputVerbGetExportName(_verbIndexB), ", alternate=", _alternateB, ")");
            InputBindingSwap(_forGamepad, _verbIndexA, _alternateA, _verbIndexB, _alternateB, _playerIndex);
            return true;
        }
        else
        {
            __InputTrace("New binding (", _binding, ") is the same as existing binding (forGamepad=", _forGamepad, ", verb=", InputVerbGetExportName(_verbIndexA), ", alternate=", _alternateA, ")");
        }
    }
    
    return false;
}
