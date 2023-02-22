//A call to input_tick() is only needed in versions of GameMaker earlier than 2022.5
//If you are using earlier versions than you must only call input_tick() once a frame
input_tick(true);

//Scan for new input from a new source, and assign it to an unconnected player
var _new_source = input_source_detect_new();
if (_new_source != undefined)
{
    var _i = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        if (!input_player_connected(_i))
        {
            input_source_set(_new_source, _i, true);
            input_consume(all, _i);
            break;
        }
        
        ++_i;
    }
}

//If a player presses a pause button, disconnect them
var _i = 0;
repeat(INPUT_MAX_PLAYERS)
{
    if (input_player_connected(_i))
    {
        if (input_check_pressed("pause", _i)) input_source_clear(_i);
    }
    
    ++_i;
}

//Do something when we see a change in the state of our players
var _status = input_players_get_status();
if (is_struct(_status))
{
    //We've seen at least one disconnection - destroy an existing player object
    if (array_length(_status.new_disconnections) > 0)
    {
        var _i = 0;
        repeat(array_length(_status.new_disconnections))
        {
            var _new_player = _status.new_disconnections[_i];
            with(obj_example_mp_player)
            {
                if (player == _new_player) instance_destroy();
            }
            
            ++_i;
        }
    }
    
    //We've seen at least one connection - create a new player object
    if (array_length(_status.new_connections) > 0)
    {
        var _i = 0;
        repeat(array_length(_status.new_connections))
        {
            var _new_player = _status.new_connections[_i];
            
            //Make sure we don't accidentally spawn one than one object per player
            var _existing = false;
            with(obj_example_mp_player)
            {
                if (player == _new_player)
                {
                    _existing = true;
                    break;
                }
            }
            
            if (!_existing)
            {
                //Spawn a player at the necessary spawn point
                with(obj_example_drop_in_spawn_point)
                {
                    if (player == _new_player)
                    {
                        var _instance = instance_create_layer(x, y, layer, obj_example_mp_player);
                        _instance.player = player;
                    }
                }
            }
            
            ++_i;
        }
    }
}
