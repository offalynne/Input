/// @desc    Creates a chord verb that is considered active when all of its constituent verbs are active
///          The maxTimeBetweenPresses argument determines how far apart each verb activation is allowed to be
///          The units for maxTimeBetweenPresses is determined by INPUT_TIMER_MILLISECONDS
/// @param   name
/// @param   maxTimeBetweenPresses
/// @param   verb1
/// @param   verb2
/// @param   ...

function input_chord_create()
{
    __input_initialize();
    
    var _name     = argument[0];
    var _max_time = argument[1] ?? INPUT_CHORD_DEFAULT_TIME;
    
    __input_ensure_unique_verb_name(_name);
    
    //Build a verb array from the remaining arguments for this function
    var _verb_array = array_create(argument_count - 2);
    var _i = 0;
    repeat(array_length(_verb_array))
    {
        _verb_array[@ _i] = argument[_i+2];
        ++_i;
    }
    
    var _chord_definition = new __input_class_chord_definition(_name, _max_time, _verb_array);
    
    //Store this globally for uniqueness checks later
    global.__input_all_verb_dict[$ _name] = true;
    array_push(global.__input_all_verb_array, _name);
    
    global.__input_chord_verb_dict[$ _name] = _chord_definition;
    array_push(global.__input_chord_verb_array, _name);
    
    //Add this chord definition to all players
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].__add_chord(_name);
        ++_p;
    }
}
