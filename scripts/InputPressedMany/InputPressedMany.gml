// Feather disable all

/// Works similarly to `InputPressed()`; please see that function for a description of behavior.
/// This variant of `InputPressed()` optionally accepts arrays for both the verb and the player
/// index and will return `true` if any of the verbs have been pressed for any of the players. You
/// may use the value `-1` for the `playerIndex` parameter to check for input across all players.
/// 
/// @param {Enum.INPUT_VERB,Real,Array} verbIndexArray
/// @param {Real,Array} [playerIndexArray=0]

function InputPressedMany(_verbIndexArray, _playerIndexArray = 0)
{
    static _verbDefIndexArray = __InputSystem().__verbDefIndexArray;
    static _playerArray = __InputSystemPlayerArray();
    
    //Convert `-1` to the array of all verb definitions
    if (is_numeric(_verbIndexArray) && (_verbIndexArray == -1))
    {
        _verbIndexArray = _verbDefIndexArray;
    }
    
    if (is_array(_verbIndexArray))
    {
        var _v = 0;
        repeat(array_length(_verbIndexArray))
        {
            if (InputPressedMany(_verbIndexArray[_v], _playerIndexArray)) return true;
            ++_v;
        }
    }
    else //not is_array(_verbIndexArray)
    {
        if (is_array(_playerIndexArray))
        {
            var _p = 0;
            repeat(array_length(_playerIndexArray))
            {
                if (InputPressed(_verbIndexArray, _playerIndexArray[_p])) return true;
                ++_p;
            }
        }
        else if (_playerIndexArray == -1)
        {
            var _playerIndex = 0;
            repeat(INPUT_MAX_PLAYERS)
            {
                if (InputPressed(_verbIndexArray, _playerIndex)) return true;
                ++_playerIndex;
            }
        }
        else
        {
            return InputPressed(_verbIndexArray, _playerIndexArray);
        }
    }
    
    return false;
}