// Feather ignore all
 
/// Checks whether a specific Input Plug-in has been registered at all.
/// This should preferably be used in conjunction with "InputPlugInRegisterName" as apart of the callback function.
///
/// NOTE: Plug-ins only register after the very first Input tick has fired!
/// @param {String} plugInName Plug-In to check
function InputPlugInIsRegistered(_plugInName) 
{
    static _registerdList = __InputSystem().__pluginsList;
    return array_contains(_registerdList, _plugInName);
}