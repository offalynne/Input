/// @param name
/// @param defaultBinding
/// @param [alternate]

function input_verb_build(_name, _binding, _alternate = 0)
{
	__input_initialize();
    __INPUT_VERIFY_ALTERNATE_INDEX
    
    if (!input_value_is_binding(_binding))
    {
        __input_error("Value provided is not a binding");
        return undefined;
    }
    
    //Get the name of the config we want to write to
    var _config_name = global.__input_default_player.__get_config_name_from_binding(_binding);
    
    //If we haven't seen this verb before...
    if (!variable_struct_exists(global.__input_basic_verb_dict, _name))
    {
        //Validate the verb name
        __input_ensure_unique_verb_name(_name);
        
        switch(_config_name)
        {
            case __INPUT_CONFIG_KEYBOARD: if (global.__input_keyboard_allowed) global.__input_keyboard_default_defined = true; break;
            case __INPUT_CONFIG_MOUSE:    if (global.__input_mouse_allowed)    global.__input_mouse_default_defined    = true; break;
            case __INPUT_CONFIG_GAMEPAD:                                       global.__input_gamepad_default_defined  = true; break;
            case __INPUT_CONFIG_JOYCON:                                        global.__input_joycon_default_defined   = true; break;
        }
        
        //And then register it
        global.__input_all_verb_dict[$ _name] = true;
        array_push(global.__input_all_verb_array, _name);
        
        global.__input_basic_verb_dict[$ _name] = true;
        array_push(global.__input_basic_verb_array, _name);
        
        //Ensure binding slots for all players
        with(global.__input_default_player)
        {
            global.__input_default_player.__ensure_verb(_config_name, _name);
        }
        
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            global.__input_players[_p].__ensure_verb(_config_name, _name);
            ++_p;
        }
    }
    
    //Set the binding on the default player
    with(global.__input_default_player)
    {
        if (__get_binding(_config_name, _name, _alternate) != undefined)
        {
            __input_error("Default binding already set for config=",_config_name, ", name=", _name, ", alternate=", _alternate, "\n", _binding);
        }
        else
        {
            __set_binding(_name, _alternate, _binding);
        }
    }
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].__set_binding(_name, _alternate, _binding);
        ++_p;
    }
}
