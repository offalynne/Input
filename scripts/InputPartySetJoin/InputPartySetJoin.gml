// Feather disable all

/// Sets whether the party-joining system should be active. Hotswapping is forcibly disabled when
/// setting the join state to `true`. By default, hotswapping is turned back on when setting the
/// join state to `false`.
/// 
/// @param {Boolean} state
/// @param {Boolean} [hotswapWhenOff=true]

function InputPartySetJoin(_state, _hotswapWhenOff = true)
{
    static _system = __InputPartySystem();
    
    _system.__joining = _state;
    
    if (_state)
    {
        InputSetHotswap(false);
    }
    else
    {
        if (_hotswapWhenOff) InputSetHotswap(true);
    }
}