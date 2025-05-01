// Feather disable all

/// Resets the metadata for a player's verb to the value set by `InputDefineVerb()`.
/// 
/// @param {Enum.INPUT_VERB,Real} verb
/// @param {Real} [playerIndex=0]

function InputVerbResetMetadata(_verb, _playerIndex = 0)
{
    static _verbDefinitionArray = __InputSystem().__verbDefinitionArray;
    static _playerArray         = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    var _verbMetadataArray = _playerArray[_playerIndex].__verbMetadataArray
    _verbMetadataArray[@ _verb] = variable_clone(_verbDefinitionArray[_verb].__metadata);
}