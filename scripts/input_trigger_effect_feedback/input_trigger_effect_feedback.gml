// Feather disable all
/// @desc    Sets gamepad trigger effect to feedback for a player
/// @param   trigger
/// @param   position
/// @param   strength
/// @param   [playerIndex=0]

function input_trigger_effect_feedback(_trigger, _position, _strength, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX

    _global.__players[_player_index].__trigger_effect_set(_trigger, new __input_class_trigger_effect_feedback(_position, _strength), true);
}
