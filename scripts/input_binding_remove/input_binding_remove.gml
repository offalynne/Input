/// @desc    Removes a binding from the player. Be careful with this function!
/// @param   {String} _verb
/// @param   {Real} _player_index
/// @param   {Real} _alternate
/// @param   {String, Undefined} _profile_name

function input_binding_remove(_verb, _player_index = 0, _alternate = 0, _profile_name = undefined)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_ALTERNATE_INDEX
    __INPUT_VERIFY_PROFILE_NAME
    
    global.__input_players[_player_index].__binding_remove(_profile_name, _verb, _alternate);
}