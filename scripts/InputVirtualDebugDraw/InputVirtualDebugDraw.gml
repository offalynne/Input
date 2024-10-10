// Feather disable all

/// Draws a visualisation aid for virtual buttons. This should be called in a Draw GUI event for
/// accurate results.

function InputVirtualDebugDraw()
{
    static _virtualButtonArray = __InputSystem().__virtualButtonArray;
    
    var _i = 0;
    repeat(array_length(_virtualButtonArray))
    {
        _virtualButtonArray[_i].DebugDraw();
        ++_i;
    }
}
