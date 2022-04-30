/// @param verbName
/// @param defaultBinding
/// @param [alternate=0]
/// @param [profileName]

function input_verb_build(_verb_name, _binding, _alternate = 0, _profile_name = undefined)
{
	__input_initialize();
    __INPUT_VERIFY_ALTERNATE_INDEX
    __INPUT_VERIFY_PROFILE_NAME
    
    if (!input_value_is_binding(_binding))
    {
        __input_error("Value provided is not a binding");
        return undefined;
    }
    
    //If we haven't seen this verb before...
    if (!variable_struct_exists(global.__input_basic_verb_dict, _verb_name))
    {
        //Validate the verb name
        __input_ensure_unique_verb_name(_verb_name);
        
        switch(_binding.__get_source())
        {
            case INPUT_SOURCE.KEYBOARD: if (global.__input_keyboard_allowed) global.__input_any_keyboard_binding_defined = true; break;
            case INPUT_SOURCE.MOUSE:    if (global.__input_mouse_allowed)    global.__input_any_mouse_binding_defined    = true; break;
            case INPUT_SOURCE.GAMEPAD:                                       global.__input_any_gamepad_binding_defined  = true; break;
        }
        
        //And then register it
        global.__input_all_verb_dict[$ _verb_name] = true;
        array_push(global.__input_all_verb_array, _verb_name);
        
        global.__input_basic_verb_dict[$ _verb_name] = true;
        array_push(global.__input_basic_verb_array, _verb_name);
        
        //Ensure binding slots for all players
        global.__input_default_player.__ensure_verb(_verb_name);
        
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            global.__input_players[_p].__ensure_verb(_verb_name);
            ++_p;
        }
    }
    
    //Set the binding on the default player
    with(global.__input_default_player)
    {
        if (__binding_get(_profile_name, _verb_name, _alternate).type != undefined)
        {
            __input_error("Default binding already set for profile=", _profile_name, ", name=", _verb_name, ", alternate=", _alternate, "\n", _binding);
        }
        else
        {
            __binding_set(_profile_name, _verb_name, _alternate, _binding);
        }
    }
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].__binding_set(_profile_name, _verb_name, _alternate, _binding);
        ++_p;
    }
}
