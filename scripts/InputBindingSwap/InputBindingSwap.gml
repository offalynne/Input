// Feather disable all

/// Swaps over two bindings. Useful to resolve binding conflicts.
/// 
/// @param {Bool} forGamepad
/// @param {Enum.INPUT_VERB,Real} verbA
/// @param {Real} alternateA
/// @param {Enum.INPUT_VERB,Real} verbB
/// @param {Real} alternateB
/// @param {Real} [playerIndex=0]

function InputBindingSwap(_forGamepad, _verbIndexA, _alternateA, _verbIndexB, _alternateB, _playerIndex = 0)
{
    __INPUT_VALIDATE_PLAYER_INDEX
    
    var _bindingA = InputBindingGet(_forGamepad, _verbIndexA, _alternateA, _playerIndex);
    var _bindingB = InputBindingGet(_forGamepad, _verbIndexB, _alternateB, _playerIndex);
    InputBindingSet(_forGamepad, _verbIndexA, _bindingB, _alternateA, _playerIndex);
    InputBindingSet(_forGamepad, _verbIndexB, _bindingA, _alternateB, _playerIndex);
}
