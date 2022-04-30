/// @param [gamepadIndex]
/// @param [playerIndex]

function input_player_claim_gamepad(_gamepad = undefined, _player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (!global.__input_any_gamepad_binding_defined)
    {
        __input_error("Player ", _player_index, " cannot claim gamepad ", _gamepad, ", no gamepad bindings have been created");
    }
    
    __input_source_relinquish(INPUT_SOURCE.GAMEPAD, _gamepad);
    global.__input_players[_player_index].__source_add(INPUT_SOURCE.GAMEPAD, _gamepad);
}
