// Feather disable all
/// @desc    Unassigns all sources for the player
/// @param   [playerIndex=0]

function input_source_clear(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_player_index == all)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            _global.__players[_i].__sources_clear();
            ++_i;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    _global.__players[_player_index].__sources_clear();
}
