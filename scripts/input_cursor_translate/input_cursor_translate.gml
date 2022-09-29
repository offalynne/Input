/// @desc    Moves a player's virtual cursor to a position, blocking input whilst the cursor is moving
///          If an axis isn't specified (<undefined> is used as a the argument value) then that axis
///          will be unbound.
///          
/// @param   [x]
/// @param   [y]
/// @param   duration
/// @param   [playerIndex=0]
/// @param   [relative=false]

function input_cursor_translate(_x = undefined, _y = undefined, _duration, _player_index = 0, _relative = false)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__cursor.__translate(_x, _y, _duration, _relative);
}