// Feather disable all

/// Returns if enough players have joined the party to continue;

function InputPartyGetReady()
{
    static _system = __InputPartySystem();
    
    var _connected = InputPlayerConnectedCount();
    return ((_connected >= _system.__minPlayers) && (_connected < _system.__maxPlayers));
}