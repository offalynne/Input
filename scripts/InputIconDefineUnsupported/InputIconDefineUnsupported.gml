// Feather disable all

/// Sets icon data to return when a binding is unsupported on the target device.
/// 
/// @param {Any} iconData

function InputIconDefineUnsupported(_iconData)
{
    static _system = __InputIconSystem();
    
    _system.__unsupported = _iconData;
}