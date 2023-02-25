/// @desc    Deactivates a verb until the button (or other physical input) is released and pressed again
///          If an array of verbs is given then this function will consume all verbs in the array
///          If the keyword <all> is used then all exant verbs are consumed
/// @param   verb/array
/// @param   [playerIndex]

function input_verb_consume(_verb, _player_index = 0)
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
    
    if (_verb == all)
    {
        var _verb_names = variable_struct_get_names(_global.__players[_player_index].__verb_state_dict);
        var _v = 0;
        repeat(array_length(_verb_names))
        {
            input_verb_consume(_verb_names[_v], _player_index);
            ++_v;
        }
    }
    else if (is_array(_verb))
    {
        var _v = 0;
        repeat(array_length(_verb))
        {
            input_verb_consume(_verb[_v], _player_index);
            ++_v;
        }
    }
    else
    {
        var _verb_struct = _global.__players[_player_index].__verb_state_dict[$ _verb];
        if (!is_struct(_verb_struct))
        {
            __input_error("Verb not recognised (", _verb, ")");
            return undefined;
        }
        
        with(_verb_struct)
        {
            __consumed     = true;
            previous_held  = true; //Force the held state on to avoid unwanted early reset of a __consumed verb
            __inactive     = true;
            __toggle_state = false; //Used for "toggle momentary" accessibility feature
        }
    }
}