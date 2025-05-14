// Feather disable all

/// @param verbGroupIndex
/// @param state
/// @param [playerIndex=0]
/// @param [exclusive=false]

function InputVerbGroupSetActive(_verbGroupIndex, _state, _playerIndex = 0, _exclusive = false)
{
    static _verbGroupInactiveArray = __InputVerbGroupSystem().__verbGroupInactiveArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX;
    
    if (_exclusive)
    {
        //Deactivate all verb groups
        _verbGroupInactiveArray[_playerIndex] = 0xFFFF_FFFF_FFFF_FFFF;
    }
    
    if (_state)
    {
		_verbGroupInactiveArray[_playerIndex] &= ~(1 << _verbGroupIndex);
    }
    else
    {
		_verbGroupInactiveArray[_playerIndex] |= (1 << _verbGroupIndex);
    }
}