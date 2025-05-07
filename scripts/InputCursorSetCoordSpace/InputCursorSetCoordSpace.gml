// Feather disable all

/// @param coordSpace

function InputCursorSetCoordSpace(_coordSpace)
{
    static _system = __InputCursorSystem();
    
    _system.__coordSpace = _coordSpace;
}