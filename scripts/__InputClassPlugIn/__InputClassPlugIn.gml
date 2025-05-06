// Feather disable all

/// @param alias
/// @param author
/// @param version
/// @param targetInputVersion
/// @param initCallback

function __InputClassPlugIn(_alias, _author, _version, _targetInputVersion, _initCallback) constructor
{
    __alias              = _alias;
    __author             = _author;
    __version            = _version;
    __targetInputVersion = _targetInputVersion;
    __initCallback       = _initCallback;
    
    static __Initialize = function()
    {
        __InputTrace($"Welcome to the {__alias} plug-in by {__author}! This is version {__version} for Input {__targetInputVersion}");
        __initCallback();
    }
}