// Feather disable all

/// Returns the y coordinate of the mouse point in device-space.

function InputMouseDeviceY()
{
    static _system = __InputSystem();
    return _system.__pointerDeviceY;
}