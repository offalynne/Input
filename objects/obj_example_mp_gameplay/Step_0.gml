//Allow player 1 to quit back to the join menu
if (input_check_pressed("pause", 0))
{
    room_goto(rm_example_mp);
}

//Return to the join room if either player disconnects
var _status = input_players_get_status();
if (is_struct(_status))
{
    if (array_length(_status.new_disconnections) > 0)
    {
        room_goto(rm_example_mp);
    }
}
