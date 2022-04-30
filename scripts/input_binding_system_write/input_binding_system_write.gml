/// @param [playerIndex]

function input_binding_system_write(_player_index = all)
{
    if ((_player_index < 0) && (_player_index != all))
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    if (__INPUT_ON_WEB) __input_error("Due to up-stream bug in GameMaker's JavaScript runtime, input_binding_system_read() and input_binding_system_write() are unsupported in HTML5");
    
    var _profile_from_json = undefined;
    
    if (_player_index == all)
    {
        var _profile_from_json = array_create(INPUT_MAX_PLAYERS, undefined);
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            _profile_from_json[@ _i] = global.__input_players[_i].__profiles_dict;
            ++_i;
        }
    }
    else
    {
        _profile_from_json = global.__input_players[_player_index].__profiles_dict;
    }
    
    return json_stringify(_profile_from_json);
}