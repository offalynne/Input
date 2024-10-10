// Feather disable all

/// Returns the current update frame number for the library. This is an internal value that is
/// incremented by 1 every time the update loop occurs.

function InputPlugInGetFrame()
{
    static _system = __InputSystem();
    return _system.__frame;
}