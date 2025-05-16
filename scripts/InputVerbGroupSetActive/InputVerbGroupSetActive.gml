// Feather disable all

/// Sets whether a verb group should be active or not. An inactive verb group will cause any verbs
/// inside of it to have their raw value set to 0. If the verb is currently active (e.g. a player
/// is holding down a keyboard key) then the verb will be considered "released" for a single frame
/// after the verb group has been deactivated.
/// 
/// If the `exclusive` parameter is set to `true` then all other verb groups will be deactivated.
/// This optional argument only applies when the `state` parameter is set to `true` (otherwise you
/// might accidentally deactivate all verbs in your game!).
/// 
/// @param verbGroupIndex
/// @param state
/// @param [playerIndex=0]
/// @param [exclusive=false]

function InputVerbGroupSetActive(_verbGroupIndex, _state, _playerIndex = 0, _exclusive = false)
{
    static _verbGroupInactiveArray = __InputVerbGroupSystem().__verbGroupInactiveArray;
    
    __INPUT_VALIDATE_PLAYER_INDEX;
    
    if (_state)
    {
        if (_exclusive)
        {
            //Deactivate all other verb groups
		    _verbGroupInactiveArray[@ _playerIndex] = ~(1 << _verbGroupIndex);
        }
        else
        {
		    _verbGroupInactiveArray[@ _playerIndex] &= ~(1 << _verbGroupIndex);
        }
    }
    else
    {
		_verbGroupInactiveArray[@ _playerIndex] |= (1 << _verbGroupIndex);
    }
}