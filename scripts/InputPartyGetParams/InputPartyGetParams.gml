// Feather disable all

/// Returns parameters (set by InputPartySetParams()) in a struct. This struct is static and
/// should therefore only be used for temporary reading of data.

function InputPartyGetParams()
{
    static _system = __InputPartySystem();
    static _params = {};
    
    with(_params)
    {
        minPlayers     = _system.__minPlayers;
        maxPlayers     = _system.__maxPlayers;
        fillEmpty      = _system.__fillEmpty;
        joinVerb       = _system.__joinVerb;
        leaveVerb      = _system.__leaveVerb;
        abortCallback  = _system.__abortCallback;
        hotswapOnAbort = _system.__hotswapOnAbort;
    }
    
    return _params;
}