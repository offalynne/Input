// Feather disable all

/// Returns the current library up time. This is measured by incrementing an internal counter
/// by `delta_time/1000` and as such will be inaccurate over large spans of time.

function InputPlugInGetTime()
{
    static _system = __InputSystem();
    return _system.__time;
}