// Feather disable all

/// Sets whether the party-joining system should be active. Hotswapping is forcibly disabled when
/// setting the join state to `true`. However, when setting the join state to `false` (for example,
/// when aborting the joining system or when advancing to gameplay) then you have the turn hotswap
/// back on.
/// 
/// If you set the optional `hotswapWhenOff` argument to `true` then hotswapping will be re-enabled
/// when disabling the party-joining system. If you set `hotswapWhenOff` to `false` then no change
/// will be made to the hotswapping state. If you leave `hotswapWhenOff` as unset or use `undefined`
/// as the value then the party system will re-enable hotswapping if there is only one player
/// connected.
/// 
/// @param {Boolean} state
/// @param {Boolean} [hotswapWhenOff]

function InputPartySetJoin(_state, _hotswapWhenOff)
{
    static _system = __InputPartySystem();
    
    if (_state)
    {
        InputSetHotswap(false);
    }
    else
    {
        if (_hotswapWhenOff ?? (InputPlayerConnectedCount() <= 1))
        {
            InputSetHotswap(true);
        }
    }
    
    _system.__joining = _state;
}