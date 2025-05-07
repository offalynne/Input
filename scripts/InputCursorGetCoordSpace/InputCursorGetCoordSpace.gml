// Feather disable all

function InputCursorGetCoordSpace()
{
    static _system = __InputCursorSystem();
    
    return _system.__coordSpace;
}