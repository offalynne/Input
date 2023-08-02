// Feather disable all
function __input_class_chord_state(_name, _chord_definition_struct) constructor
{
    __name = _name;
    __definition_struct = _chord_definition_struct;
    
    __start_time = infinity;
    __state = 0; //0 = wait for any to be held, 1 = wait for all to be held, 2 = wait for any release, 3 = wait for all to release
    
    static __evaluate = function(_player_verb_struct)
    {
        var _verb_array = __definition_struct.__verb_array;
        var _verb_count = array_length(_verb_array);
        
        switch(__state)
        {
            case 0:
                //Wait until any verb is held
                //This allows us to time how long it takes for the chord to be activated
                
                var _i = 0;
                repeat(_verb_count)
                {
                    if (_player_verb_struct[$ _verb_array[_i]].held)
                    {
                        __start_time = __input_get_time();
                        __state = 1;
                        return __evaluate(_player_verb_struct); //Continue evaluating to catch single-frame chord presses
                    }
                    
                    ++_i;
                }
                
                return false;
            break;
            
            case 1:
                //Check for timeout from the initial press
                if (__input_get_time() - __start_time > __definition_struct.__max_time_between_presses)
                {
                    __state = 3;
                    return false;
                }
                
                //Wait until all verbs are held
                //Since we evaluate every frame, this means we're waiting until the last verb is pressed
                var _i = 0;
                repeat(_verb_count)
                {
                    if (!_player_verb_struct[$ _verb_array[_i]].held) return false;
                    ++_i;
                }
                
                __state = 2;
                return true;
            break;
            
            case 2:
                //Wait until one of the verbs is released
                
                var _i = 0;
                repeat(_verb_count)
                {
                    if (!_player_verb_struct[$ _verb_array[_i]].held)
                    {
                        __state = 3;
                        return false;
                    }
                    
                    ++_i;
                }
                
                return true;
            break;
            
            case 3:
                //Wait until all of the verbs are released, then return back to the initial state
                
                var _i = 0;
                repeat(_verb_count)
                {
                    if (_player_verb_struct[$ _verb_array[_i]].held) return false;
                    ++_i;
                }
                
                __start_time = infinity;
                __state = 0;
                return false;
            break;
            
            default:
                __input_error("State \"", __state, "\" not recognised");
            break;
        }
    }
}
