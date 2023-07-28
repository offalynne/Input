// Feather disable all
/// @desc    Returns a struct that describes the status of gamepad connectivity
/// 
/// N.B. Do not edit the returned struct! You may encounter undefined behaviour if you do
/// 
/// {
///     any_changes: <boolean that indicates whether anything has changed at all>
///     new_connections: [
///         <array of gamepad indexes that are newly connected this step>
///     ],
///     new_disconnections: [
///         <array of gamepad indexes that are newly disconnected this step>
///     ],
///     gamepads: [
///         <array of values from the INPUT_STATUS enum, one for each gamepad available on this platform>
///     ],
/// }

function input_gamepads_get_status()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    return _global.__gamepads_status;
}
