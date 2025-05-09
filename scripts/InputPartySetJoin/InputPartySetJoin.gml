// Feather disable all

/// Sets whether the party-joining system should be active. Hotswapping is forcibly disabled when
/// setting the join state to `true`. By default, hotswapping is turned back on when setting the
/// join state to `false`.
/// 
/// @param {Boolean} state
/// @param {Boolean} [hotswapWhenOff=true]

function InputPartySetJoin(_state, _hotswapWhenOff = true)
{
    static _system        = __InputPartySystem();
    static _leaveStateMap = _system.__leaveStateMap;
    
    if (_state)
    {
        InputSetHotswap(false);
    }
    else
    {
        if (_hotswapWhenOff) InputSetHotswap(true);
        
        //Clear out our leave state map so it doesn't persist into the next time we enter join mode.
        if (_system.__joining) ds_map_clear(_leaveStateMap);
    }
    
    _system.__joining = _state;
}