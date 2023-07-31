// Feather disable all
/// @desc    Returns a struct that describes the status of player connectivity
/// 
/// N.B. Do not edit the returned struct! You may encounter undefined behaviour if you do
/// 
/// {
///     any_changes: <boolean that indicates whether anything has changed at all>
///     new_connections: [
///         <array of player indexes that are newly connected this step>
///     ],
///     new_disconnections: [
///         <array of player indexes that are newly disconnected this step>
///     ],
///     players: [
///         <array of values from the INPUT_STATUS enum, one for each player up to INPUT_MAX_PLAYERS>
///     ],
/// }

function input_players_get_status()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    return _global.__players_status;
}
