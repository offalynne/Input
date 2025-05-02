function __InputPlugInDependencyCheck(_entry, _dependencies, _errorIfNotFound = true) {
    static _queueList = __InputSystem().__pluginsListQueue;
    
    static _ctx = {__name: undefined};
    static _dependencyCheckCallback = method(_ctx, function(_elm) { return _elm.__name == __name; });
    static _circularCheckCallback = method(_ctx, function(_elm) { return _elm == __name; });

    var _plugInName = _entry.__name;
    var _i = 0;
    // Check if dependencies are all registered!
    repeat(array_length(_dependencies)) 
    {
        var _dependencyName = _dependencies[_i];
        _ctx.__name = _dependencyName;
        // Check if dependency isn't named same as self
        if (_plugInName == _dependencyName) 
        {
            __InputError($"Plug-in \"{_plugInName}\" has a dependency of itself!");
            return;
        }

        if (!InputPlugInIsRegistered(_dependencyName)) 
        {
            var _index = array_find_index(_queueList, _dependencyCheckCallback);
            if (_index >= 0) 
            {
                // Check for circular dependency
                var _dependency = _queueList[_index];
                _ctx.__name = _plugInName;
                if (array_find_index(_dependency.__dependencies, _circularCheckCallback) >= 0) 
                {
                    __InputError($"Circular reference found amongst plug-ins \"{_plugInName}\" and \"{_dependencyName}\"!\nPlease remove a dependency from either one of them.");
                    return;
                }
                return false;
            } 
            else if (_errorIfNotFound) 
            {
                __InputError($"Plug-in \"{_plugInName}\" doesn't have a dependency included called \"{_dependencyName}\"!");
                return;
            }
        }
        ++_i;
    }
    
    return true;
}


