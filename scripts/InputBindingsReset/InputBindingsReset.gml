// Feather disable all

/// Resets all bindings to the defaults defined by `InputDefineVerb()`.
/// 
/// @param {Bool} forGamepad
/// @param {Real} [playerIndex=0]

function InputBindingsReset(_forGamepad, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    if (_forGamepad)
    {
        array_map_ext(_playerArray[_playerIndex].__gamepadBindingArray, function(_element, _index)
        {
            static _verbArray = __InputSystem().__verbDefinitionArray;
            return variable_clone(_verbArray[_index].__gamepadBinding);
        });
    }
    else
    {
        array_map_ext(_playerArray[_playerIndex].__kbmBindingArray, function(_element, _index)
        {
            static _verbArray = __InputSystem().__verbDefinitionArray;
            return variable_clone(_verbArray[_index].__kbmBinding);
        });
    }
}