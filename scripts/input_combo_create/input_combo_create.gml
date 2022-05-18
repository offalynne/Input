/// @param name
/// @param [defaultTimeout]

function input_combo_create(_name, _default_timeout = INPUT_TIMER_MILLISECONDS? 333 : 20)
{
    __input_ensure_unique_verb_name(_name);
    
    var _combo_definition = new __input_class_combo_definition(_name, _default_timeout);
    
    //Store this globally for uniqueness checks later
    global.__input_all_verb_dict[$ _name] = true;
    array_push(global.__input_all_verb_array, _name);
    
    global.__input_combo_verb_dict[$ _name] = _combo_definition;
    array_push(global.__input_combo_verb_array, _name);
    
    //Add this combo definition to all players
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].__add_combo(_name);
        ++_p;
    }
    
    //Return the combo struct so that the developer can add phases to it
    return _combo_definition;
}
