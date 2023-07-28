// Feather disable all
/// @desc    Reads a JSON (string or struct) that contains player data and verifies if it can be imported without error
/// @param   stringOrJSON
/// @param   [playerIndex=0]

function input_player_verify(_json, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    //Make a clone of the current settings
    var _backup = input_player_export(_player_index, false);
    
    var _error = undefined;
    try
    {
        _global.__players[_player_index].__import(_json);
    }
    catch(_error)
    {
        __input_trace("input_player_verify() failed with the following error: ", _error);
    }
    
    //Restore the clone of the current settings
    input_player_import(_backup, _player_index);
    
    return (_error == undefined);
}
