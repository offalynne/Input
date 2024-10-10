// Feather disable all

/// @param verbIndex

function __InputClassVerbState(_verbIndex) constructor
{
    __verbIndex = _verbIndex;
    
    __prevHeld   = false;
    __held       = false;
    __valueRaw   = 0;
    __valueClamp = 0;
    __pressFrame = -infinity;
}