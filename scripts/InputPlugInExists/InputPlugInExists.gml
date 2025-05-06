// Feather disable all

/// Returns if a plug-in with the given alias exists. Aliases are case sensitive.
/// 
/// @param alias

function InputPlugInExists(_alias)
{
    static _plugInDict = __InputSystem().__plugInDict;
    
    return variable_struct_exists(_plugInDict, _alias);
}