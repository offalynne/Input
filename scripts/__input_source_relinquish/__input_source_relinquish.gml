/// @param source
/// @param [gamepad]

function __input_source_relinquish(_source, _gamepad = undefined)
{
    var _i = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        with(global.__input_players[_i])
        {
            var _j = 0;
            repeat(array_length(__source_array))
            {
                if (__source_array[_j].__collides_with(_source, _gamepad))
                {
                    array_delete(__source_array, _j, 1);
                }
                else
                {
                    ++_j;
                }
            }
        }
        
        ++_i;
    }
}