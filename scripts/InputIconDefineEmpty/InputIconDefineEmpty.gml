// Feather disable all

/// Sets icon data to return when a binding is empty.
/// 
/// @param {Any} iconData

function InputIconDefineEmpty(_iconData)
{
    static _system = __InputIconSystem();
    
    _system.__empty = _iconData;
}