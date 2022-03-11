/// @param gamepad
/// @param [playerIndex]

function input_player_gamepad_set(_gamepad, _player_index = 0)
{
	__input_initialize();
	
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
    
    if (!input_gamepad_is_connected(_gamepad))
    {
        __input_trace("Failed to set player gamepad: device not connected (Index ", _gamepad , ":\"" , gamepad_get_description(_gamepad) ,"\")");
        return undefined;
    }
    
    var _player = global.__input_players[_player_index];
    if (_player.gamepad != _gamepad)
    {
        _player.last_input_time = current_time;
    }
    
    _player.gamepad = _gamepad;
}