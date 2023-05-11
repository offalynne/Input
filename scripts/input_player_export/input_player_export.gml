/// @desc    Outputs a string or struct containing the bindings, profiles and axis thresholds of the given player
/// @param   [playerIndex=0]
/// @param   [outputString=true]
/// @param   [prettify=false]

function input_player_export(_player_index = 0, _output_string = true, _prettify = false)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    return _global.__players[_player_index].__export(_output_string, _prettify);
}