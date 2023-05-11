/// @desc    Duplicates one player's bindings, profiles and axis thresholds and copies them to another
/// @param   playerIndexSrc
/// @param   playerIndexDst

function input_player_copy(_player_index_src, _player_index_dst)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    //Verify source player
    if (_player_index_src < 0)
    {
        __input_error("Invalid source player index provided (", _player_index_src, ")");
        return undefined;
    }
    
    if (_player_index_src >= INPUT_MAX_PLAYERS)
    {
        __input_error("Source player index too large (", _player_index_src, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    //Verify destination player
    if (_player_index_dst < 0)
    {
        __input_error("Invalid destination player index provided (", _player_index_dst, ")");
        return undefined;
    }
    
    if (_player_index_dst >= INPUT_MAX_PLAYERS)
    {
        __input_error("Destination player index too large (", _player_index_dst, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    input_player_import(input_player_export(_player_index_src, false, false), _player_index_dst);
}