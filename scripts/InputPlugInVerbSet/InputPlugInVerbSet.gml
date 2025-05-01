// Feather disable all

/// Must be called from within a INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER callback.
/// 
/// @param {Enum.INPUT_VERB,Real} verbIndex
/// @param {Any} value
/// @param {Any} [rawValue=value]
/// @param {Real} [playerIndex=0]

function InputPlugInVerbSet(_verbIndex, _value, _rawValue = _value, _playerIndex = 0)
{
    static _system      = __InputSystem();
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    if (_system.__plugInCurrentCallback != INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER)
    {
        __InputError("Cannot call InputPlugInVerbSet() outside of a INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER callback");
    }
    
    with(_playerArray[_playerIndex].__verbStateArray[_verbIndex])
    {
        __valueRaw   = _rawValue;
        __valueClamp = _value;
    }
}