// Feather disable all
/// @desc    Swaps over two bindings within the same profile. This is useful to resolve binding conflicts
/// @param   verbA
/// @param   alternateA
/// @param   verbB
/// @param   alternateB
/// @param   [playerIndex=0]
/// @param   [profileName]

function input_binding_swap(_verb_a, _alternate_a, _verb_b, _alternate_b, _player_index = 0, _profile_name = undefined)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_PROFILE_NAME
    
    var _binding_a = input_binding_get(_verb_a, _player_index, _alternate_a, _profile_name);
    var _binding_b = input_binding_get(_verb_b, _player_index, _alternate_b, _profile_name);
    
    if (_binding_b == undefined)
    {
        input_binding_remove(_verb_a, _player_index, _alternate_a, _profile_name);
    }
    else
    {
        input_binding_set(_verb_a, _binding_b, _player_index, _alternate_a, _profile_name);
    }
    
    if (_binding_a == undefined)
    {
        input_binding_remove(_verb_b, _player_index, _alternate_b, _profile_name);
    }
    else
    {
        input_binding_set(_verb_b, _binding_a, _player_index, _alternate_b, _profile_name);
    }
}
