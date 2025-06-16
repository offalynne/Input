// Feather disable all

/// Defines a plug-in for use with Input.
/// 
/// N.B. `InputPlugInDefine()` should be called on boot, that is to say it should be called in
///      global scope in a script. Input must know about plug-ins before the first GameMaker step.
/// 
/// This function creates a representation of your plug-in inside Input. You should supply an alias
/// for the plug-in, your name, and a version for the plug-in itself. These should all be strings.
/// The alias is case sensitive. The version number should be in the format `"major.minor.patch"`
/// as per semantic versioning. Only the major and minor version numbers will be used for
/// comparisons, but it's good practice to use all three numbers nonetheless.
/// 
/// N.B. Please update your plug-in's version number whenever you publish a meaningful update.
///      Keeping your own version number up to date helps with diagnosing your own bugs as well as
///      helping create a community of interdependent plug-ins.
/// 
/// The alias must be universally unique so choose something distinctive! We recommend an alias
/// along the lines of `"YourName.PlugInTitle"`. The native gamepad color plug-in uses
/// `"InputTeam.GamepadColor"`, for example.
/// 
/// `targetInputVersion` should be a string too and should be in the format `"major.minor"`. This
/// version number is checked against the version of Input that is currently running.
/// 
/// N.B. Please define a static value for `targetInputVersion` and do not use `INPUT_VERSION`!
/// 
/// Immediately before Input performs its very first update, the initialization callback that you
/// have defined in the `initCallback` parameter will be executed. This is where you should call
/// `InputPlugInRegisterCallback()` to hook up your plug-in to Input's callback system. All plug-in
/// initialization callbacks will be executed when Input collects raw verb state for the first
/// time. This is typically in the first room but, depending on how the end-user is making use of
/// Input, when and what room this happens in is not guaranteed. Plug-ins will also be initialized
/// before player 0 is given a default device.
/// 
/// @param alias
/// @param author
/// @param version
/// @param targetInputVersion
/// @param initCallback

function InputPlugInDefine(_alias, _author, _version, _targetInputVersion, _initCallback)
{
    static _system      = __InputSystem();
    static _plugInArray = _system.__plugInArray;
    static _plugInDict  = _system.__plugInDict;
    
    if (_system.__plugInsInitializeState != 0)
    {
        __InputError("`InputPlugInDefine()` must only be called on boot");
    }
    
    if (variable_struct_exists(_plugInDict, _alias))
    {
        __InputError("Plug-in with alias \"", _alias, "\" already exists");
    }
    
    if (not __InputCompareVersions(_targetInputVersion, INPUT_VERSION))
    {
        __InputError("Plug-in \"", _alias, "\" is incompatible with this version of Input (", INPUT_VERSION, ")\nTarget Input version is ",  _targetInputVersion);
    }
    
    var _plugInStruct = new __InputClassPlugIn(_alias, _author, _version, _targetInputVersion, _initCallback);
    
    array_push(_plugInArray, _plugInStruct);
    _plugInDict[$ _alias] = _plugInStruct;
}