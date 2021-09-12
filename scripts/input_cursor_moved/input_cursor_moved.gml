/// @param [playerIndex]
/// @param [bufferDuration]

function input_cursor_moved(_player_index = 0, _buffer_duration = undefined)
{
    if (INPUT_WARNING_DEPRECATED) __input_error("This function has been deprecated\n(Set INPUT_WARNING_DEPRECATED to <false> to ignore this warning)");
    
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    if (_buffer_duration == undefined)
    {
        //If we have an undefined duration, choose 95% of the realtime frame time
        //If we're not using realtime tracking, choose "same frame" as the buffer duration
        _buffer_duration = INPUT_TIMER_MILLISECONDS? (0.95*game_get_speed(gamespeed_microseconds)/1000) : 0;
    }
    
    with(global.__input_players[_player_index].cursor)
    {
        return ((moved_time >= 0) && ((__input_get_time() - moved_time) <= _buffer_duration));
    }
}