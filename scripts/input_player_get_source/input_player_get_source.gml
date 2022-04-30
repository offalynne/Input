/// @param [playerIndex]

function input_player_get_source(_player_index = 0)
{
    var _array = input_player_get_source_array(_player_index);
    if (array_length(_array) <= 0) return INPUT_NONE;
    return _array[0];
}