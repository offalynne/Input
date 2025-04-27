// Feather disable all

/// Returns the x coordinate of the mouse point in room-space.

function InputMouseRoomX()
{
    static _system = __InputSystem();
    return (_system.__pointerBlocked)? _system.__pointerRoomX : device_mouse_x(0);
}