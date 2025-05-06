// Feather disable all

/// @param alias
/// @param version
/// @param [alias]
/// @param [version]
/// @param ...

function InputPlugInAssertDependencies()
{
    static _plugInDict = __InputSystem().__plugInDict;
    
    var _i = 0;
    repeat(argument_count div 2)
    {
        var _plugInStruct = _plugInDict[$ argument[_i]];
        
        if (not is_struct(_plugInStruct))
        {
            __InputError($"Plug-in \"{argument[_i]}\" required as a dependency but it cannot be found\nPlease import this missing plug-in");
            return false;
        }
        
        if (not __InputCompareVersions(argument[_i+1], _plugInStruct.__version))
        {
            __InputError($"Required version ({argument[_i+1]}) of plug-in \"{argument[_i]}\" is newer than current version {_plugInStruct.__version}\nPlease check for updates");
            return false;
        }
        
        _i += 2;
    }
    
    return true;
}