// Feather disable all

/// @param alias

function InputPlugInExists(_alias)
{
    static _plugInDict = __InputSystem().__plugInDict;
    
    return variable_struct_exists(_plugInDict, _alias);
}