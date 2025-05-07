// Feather disable all

/// Returns the global coordinate space. It should be one of the `INPUT_CURSOR_*_SPACE` macros:
/// 
/// - `INPUT_CURSOR_ROOM_SPACE`
/// - `INPUT_CURSOR_GUI_SPACE`
/// - `INPUT_CURSOR_DEVICE_SPACE`

function InputCursorGetCoordSpace()
{
    static _system = __InputCursorSystem();
    
    return _system.__coordSpace;
}