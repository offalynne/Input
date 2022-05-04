#macro __INPUT_VERIFY_PLAYER_INDEX  if (_player_index < 0)\
                                    {\
                                        __input_error("Invalid player index provided (", _player_index, ")");\
                                        return undefined;\
                                    }\
                                    if (_player_index >= INPUT_MAX_PLAYERS)\
                                    {\
                                        __input_error("Player index too large (", _player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");\
                                        return undefined;\
                                    }

#macro __INPUT_GET_VERB_STRUCT  var _verb_struct = global.__input_players[_player_index].__verb_state_dict[$ _verb];\
                                if (!is_struct(_verb_struct))\
                                {\
                                    __input_error("Verb not recognised (", _verb, ")");\
                                    return undefined;\
                                }
                                
#macro __INPUT_VERIFY_ALTERNATE_INDEX  if (_alternate < 0)\
                                       {\
                                           __input_error("Invalid \"alternate\" argument (", _alternate, ")");\
                                           return undefined;\
                                       }\
                                       if (_alternate >= INPUT_MAX_ALTERNATE_BINDINGS)\
                                       {\
                                           __input_error("\"alternate\" argument too large (", _alternate, " must be less than ", INPUT_MAX_ALTERNATE_BINDINGS, ")\nIncrease INPUT_MAX_ALTERNATE_BINDINGS for more alternate binding slots");\
                                           return undefined;\
                                       }

#macro __INPUT_VERIFY_BASIC_VERB_NAME  if (variable_struct_exists(global.__input_chord_verb_dict, _verb_name)) __input_error("\"", _verb_name, "\" is a chord verb. Verbs passed to this function must be basic verb");\
                                       if (variable_struct_exists(global.__input_combo_verb_dict, _verb_name)) __input_error("\"", _verb_name, "\" is a combo verb. Verbs passed to this function must be basic verb");\
                                       if (!variable_struct_exists(global.__input_basic_verb_dict, _verb_name)) __input_error("Verb \"", _verb_name, "\" not recognised");
                                       
                                       
                                       
#macro __INPUT_VERIFY_PROFILE_NAME  if (!input_profile_exists(_profile_name, _player_index)) __input_error("Profile name \"", _profile_name, "\" doesn't exist");
