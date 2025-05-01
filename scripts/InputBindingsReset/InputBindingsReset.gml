// Feather disable all

/// Resets all bindings to the defaults defined by `InputDefineVerb()`.
/// 
/// @param {Bool} forGamepad
/// @param {Real} [playerIndex=0]

function InputBindingsReset(_forGamepad, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    if (_forGamepad)
    {
        array_map_ext(_playerArray[_playerIndex].__gamepadBindingArray, function(_element, _index)
        {
            static _verbDefinitionArray = __InputSystem().__verbDefinitionArray;
            var _verbDefinition = _verbDefinitionArray[_index];
            return (_verbDefinition != undefined)? variable_clone(_verbDefinition.__gamepadBinding) : [];
        });
    }
    else
    {
        array_map_ext(_playerArray[_playerIndex].__kbmBindingArray, function(_element, _index)
        {
            static _verbDefinitionArray = __InputSystem().__verbDefinitionArray;
            var _verbDefinition = _verbDefinitionArray[_index];
            return (_verbDefinition != undefined)? variable_clone(_verbDefinition.__kbmBinding) : [];
        });
    }
}