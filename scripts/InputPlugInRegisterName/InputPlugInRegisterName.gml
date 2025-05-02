// Feather ignore all

/// Registers a new Input Plug-in to the Plug-in registry with the provided name, dependencies, optional dependencies and callback for the Plug-in to setup on the very first Input tick.
/// @param {String} plugInName Name of the Plug-In
/// @param {Array<String>, String, Undefined} dependencies Dependencies that are mandatory for this Plug-In
/// @param {Array<String>, String, Undefined} optionalDependencies Dependencies that are optional for this Plug-In
/// @param {Function} callback The callback to fire. (This is where you can setup all of your Input Plug-In callbacks)
function InputPlugInRegisterName(_plugInName, _dependencies = undefined, _optionalDependencies = undefined, _callback = undefined) 
{
    static _global = __InputSystem();
    static _queueList = _global.__pluginsListQueue;
    array_push(_queueList, 
    {
        __name: !is_string(_plugInName) ? string(_plugInName) : _plugInName,
        __dependencies: is_string(_dependencies) ? [_dependencies] : _dependencies,
        __optionalDependencies: is_string(_optionalDependencies) ? [_optionalDependencies] : _optionalDependencies,
        __callback: _callback,
    });
}