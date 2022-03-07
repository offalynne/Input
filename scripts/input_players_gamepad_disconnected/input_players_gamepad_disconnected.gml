function input_players_gamepad_disconnected()
{
    var _players = [];
    
    var _g = 0;
    repeat(array_length(global.__input_gamepad_disconnections))
    {
        var _p = 0;
        repeat(array_length(global.__input_players))
        {
            if (global.__input_gamepad_disconnections[_g] == global.__input_players[_p].gamepad)
            {
                //Add player if their gamepad index matches a disconnection
                array_push(_players, global.__input_gamepad_disconnections[_g]);
                break;
            }
            
            ++_p;
        }
    
        ++_g;
    }
    
    return _players;
}