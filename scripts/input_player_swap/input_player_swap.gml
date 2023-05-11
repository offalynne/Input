/// @desc    Swaps the player indexes over, including profiles, connected devices, and verb state
/// @param   playerIndexA
/// @param   playerIndexB

function input_player_swap(_player_index_a, _player_index_b)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_player_index_a < 0)
    {
        __input_error("Invalid player index A provided (", _player_index_a, ")");
        return undefined;
    }
    
    if (_player_index_a >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index A too large (", _player_index_a, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    if (_player_index_b < 0)
    {
        __input_error("Invalid player index B provided (", _player_index_b, ")");
        return undefined;
    }
    
    if (_player_index_b >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index B too large (", _player_index_b, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    //Do the ol' swaperoo
    var _original_a = _global.__players[_player_index_a];
    var _original_b = _global.__players[_player_index_b];
    
    _original_a.__index = _player_index_b;
    _original_b.__index = _player_index_a;
    
    _global.__players[@ _player_index_a] = _original_b;
    _global.__players[@ _player_index_b] = _original_a;
}