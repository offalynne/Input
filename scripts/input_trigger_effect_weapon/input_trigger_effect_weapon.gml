/// @desc    Sets gamepad trigger effect to weapon for a player
/// @param   trigger
/// @param   start
/// @param   end
/// @param   strength
/// @param   [playerIndex=0]

function input_trigger_effect_weapon(_trigger, _start, _end, _strength, _player_index = 0)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX

    global.__input_players[_player_index].__trigger_effect_set(_trigger, new __input_class_trigger_effect_weapon(_trigger, _start, _end, _strength), true);
}