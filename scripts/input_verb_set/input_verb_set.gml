// Feather disable all
/// @desc    Sets the value of a verb. This is "additive" to other physical inputs the player might be making
///          If you'd like to fully control a player's verbs, please set that player to ghost mode with input_player_ghost_set()
/// @param   verb
/// @param   value
/// @param   [playerIndex=0]
/// @param   [analogue=true]

function input_verb_set(_verb, _value, _player_index = 0, _analogue = true)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
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
    
    _global.__players[_player_index].__verb_set(_verb, _value, _analogue);
}
