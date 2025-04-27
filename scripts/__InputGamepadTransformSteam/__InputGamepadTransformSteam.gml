// Feather disable all

/// Transforms values stored in a gamepad struct using Steam Input. This function also does some
/// basic block checking during the transformation process to catch any weird edge cases.
/// 
/// This function is called from `__InputGamepadDiscover()`, please see that function for more
/// context. This function will only be called on desktop platforms (including Steam Deck) and only
/// when Steam Input has been initialized successfully (see `__InputInitializeSteam()`).
/// 
/// @param gamepadStruct

function __InputGamepadTransformSteam(_gamepadStruct)
{
    static _system = __InputSystem();
    static _steamInputTypeIgnoreMap = __InputSystem().__steamInputTypeIgnoreMap;
    
    //Steamworks Handling
    if (_system.__usingSteamworks)
    {
        with(_gamepadStruct)
        {
            var _gamepadIsVirtual = (INPUT_ON_WINDOWS && __xinput);
            var _gamepadIndex     = __gamepadIndex;
            
            if (INPUT_ON_LINUX)
            {
                var _gamepadHandleIndex = -1;
                _gamepadIsVirtual = false;
                
                var _i = 0;
                repeat(__gamepadIndex + 1)
                {
                    if ((gamepad_get_description(_i) == "Valve Streaming Gamepad") || __InputStringContains(gamepad_get_guid(_i), "03000000de280000fc11", "03000000de280000ff11"))
                    {
                        _gamepadHandleIndex++;
                        _gamepadIsVirtual = true;
                    }
                    ++_i;
                }
                
                _gamepadIndex = _gamepadHandleIndex;
            }
            
            if ((INPUT_ON_MACOS && (__guid == "030000005e0400008e02000001000000"))
            ||  (INPUT_ON_LINUX && (__guid == "03000000de280000ff11000001000000")))
            {
                //Steam virtual controller, ignore
                __InputTrace("Ignoring gamepad ", __gamepadIndex, " as it is a Steam virtual controller");
                __blocked = true;
                //Don't return! We still want to process Steam variables
            }
            
            __steamHandle = steam_input_get_controller_for_gamepad_index(_gamepadIndex);
            
            if not (_gamepadIsVirtual && is_numeric(__steamHandle) && (__steamHandle > 0))
            {
                __steamHandle      = undefined;
                __steamHandleIndex = undefined;
            }
            else
            {
                __steamHandleIndex = steam_input_get_gamepad_index_for_controller(__steamHandle);
                if (__steamHandleIndex == -1)
                {
                    //Steam Input has no information for us about this gamepad, skip
                    return;
                }
                
                var _steamType = steam_input_get_input_type_for_handle(__steamHandle);
                if not (is_numeric(_steamType) && (_steamType >= 0))
                {
                    __InputTrace("Warning! Steam gamepad type ", _steamType, " invalid");
                    __blocked = true;
                    return;
                }
                
                __description = _system.__steamTypeToDescriptionMap[? _steamType];
                if (__description == undefined)
                {
                    __InputTrace("Warning! Steam gamepad type ", _steamType, " has no Steam description");
                    __description = "Missing Description";
                    __blocked = true;
                    return;
                }
                
                __type = _system.__steamTypeToInputTypeMap[? _steamType];
                if (__type == undefined)
                {
                    __InputTrace("Warning! Steam-gamepad-type ", _steamType, " has no matching Input-gamepad-type");
                    __type = INPUT_GAMEPAD_TYPE_UNKNOWN;
                    __blocked = true;
                    return;
                }
            }
        }
    }
    
    //Block device types indicated by Steam Input
    if ((__vendor != "de28") && ds_map_exists(_steamInputTypeIgnoreMap, __type))
    {
        __InputTrace("Warning! Input-gamepad-type ", __type, " is blacklisted by Steam Input");
        __blocked = true;
        return;
    }
}