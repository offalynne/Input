// Feather disable all
/// @desc    Returns the activation threshold for a specific gamepad axis for a player
///          If no activation threshold has been set this function returns <undefined>
/// @param   {Constant.GamepadAxis|Constant.GamepadButton} axis
/// @param   [playerIndex]

function input_axis_threshold_get(_axis, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    return _global.__players[_player_index].__axis_threshold_get(_axis);
}
