/// @desc    Returns whether the given player has been assigned the keyboard source
/// @param   [playerIndex=0]

function InputPlayerUsingKeyboard(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _array = _global.__players[_player_index].__source_array;
    var _i = 0;
    repeat(array_length(_array))
    {
        if (_array[_i].__source == __INPUT_SOURCE.KEYBOARD) return true;
        if (INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER && (_array[_i].__source == __INPUT_SOURCE.MOUSE)) return true;
        ++_i;
    }
    
    return false;
}