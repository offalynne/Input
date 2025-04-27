// Feather disable all

/// Returns whether party joining is currently active.
/// 
/// @param {Boolean} state

function InputPartyGetJoin()
{
    static _system = __InputPartySystem();
    
    return _system.__joining;
}