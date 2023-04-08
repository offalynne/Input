/// @desc    Assigns a source to a player. All other players using the source will have it unassigned
///          If the player had any other sources assigned then they will NOT be unassigned
/// @param   source
/// @param   [playerIndex=0]
/// @param   [exclusive=true]

function input_source_add(_source, _player_index = 0, _exclusive = true)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_SOURCE
    __INPUT_VERIFY_SOURCE_ASSIGNABLE
    
    if (_exclusive) __input_source_relinquish(_source);

    _global.__players[_player_index].__source_add(_source);
}