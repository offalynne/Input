// Feather disable all

/// @param alias
/// @param author
/// @param version
/// @param targetInputVersion
/// @param initCallback

function InputPlugInDefine(_alias, _author, _version, _targetInputVersion, _initCallback)
{
    static _plugInArray = __InputSystem().__plugInArray;
    static _plugInDict  = __InputSystem().__plugInDict;
    
    if (variable_struct_exists(_plugInDict, _alias))
    {
        __InputError($"Plug-in with alias \"{_alias}\" already exists");
    }
    
    if (not __InputCompareVersions(_targetInputVersion, INPUT_VERSION))
    {
        __InputError($"Plug-in \"{_alias}\" is incompatible with this version of Input ({INPUT_VERSION})\nTarget Input version is {_targetInputVersion}");
    }
    
    var _plugInStruct = new __InputClassPlugIn(_alias, _author, _version, _initCallback);
    
    array_push(_plugInArray, _plugInStruct);
    _plugInDict[$ _alias] = _plugInStruct;
    
    __InputTrace($"Plug-in {_alias} v{_version} defined");
}