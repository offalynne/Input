// Feather disable all

/// Creates a virtual button. Virtual buttons can typically only be used if a player has been
/// assigned the `INPUT_TOUCH` device. Virtual buttons can optionally be set up to respond to
/// mouse input via the `INPUT_KBM` device; please see `INPUT_MOUSE_CAN_USE_VIRTUAL_BUTTONS`.

function InputVirtualCreate()
{
    return new __InputClassVirtualButton();
}