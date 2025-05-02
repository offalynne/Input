// Feather ignore all

function __InputPlugInRegisterInit() 
{
    static _global = __InputSystem();
    var _queueList = _global.__pluginsListQueue;
    var _registeredList = _global.__pluginsList;

    while (array_length(_queueList) > 0) 
    {
        var _entry = array_shift(_queueList);
        var _pluginName = _entry.__name;

        // Handles mandatory dependencies
        if (is_array(_entry.__dependencies)) 
        {
            // Check if dependencies are all registered!
            if (!__InputPlugInDependencyCheck(_entry, _entry.__dependencies)) {
                array_push(_queueList, _entry);
                continue;
            }
        }
        
        // Handle optional dependencies
        if (is_array(_entry.__optionalDependencies)) 
        {
            // Check if optional dependencies are all registered! If missing entirely, don't error!
            if (!__InputPlugInDependencyCheck(_entry, _entry.__optionalDependencies, false)) {
                array_push(_queueList, _entry);
                continue;
            }
        }

        if (InputPlugInIsRegistered(_pluginName)) 
        {
            __InputError($"Plug-in \"{_pluginName}\" already exists!");
            return;
        }

        // Register plugin!
        array_push(_registeredList, _pluginName);
		var _callback = _entry.__callback;
        if (is_callable(_callback)) 
        {
		  _callback();
        }
		else if (!is_undefined(_callback)) 
		{
			__InputError($"Input Plug-In registry callback invalid.\nNot type \"undefined\", \"function\" or \"method\". Got type \"{typeof(_callback)}\".");
			return;
		}
    }
}
