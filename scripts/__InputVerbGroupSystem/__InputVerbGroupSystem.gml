// Feather disable all

//Use a maximum verb group index of 50 because it's a nice round number and it gives us space for
//other modifiers in the future. The theoretical maximum 
#macro __INPUT_MAX_VERB_GROUPS  50

__InputVerbGroupSystem();
function __InputVerbGroupSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
        //Get all the verb indexes that the user has defined
        var _allVerbArray = InputPlugInGetAllVerbs();
        
        //This array isn't necessarily sequential or ordered. We can fix the last potential issue by sorting
        //the array
        array_sort(_allVerbArray, false);
        
        //Create an array to store the verb groups for all the verbs using the maximum verb index to give us
        //a maximum size. This means that all verb indexes that have been defined as initialized to a verb
        //group bitmask of 0x0000_0000_0000_0000
        __verbGroupLookupArray = array_create(_allVerbArray[0] + 1, 0x00);
        
        //Start with all verb groups set to active. This array stores a bitmask that covers whether each verb
        //group is inactive. A binary value of 0 is therefore "active" and a binary value of 1 is "inactive".
        __verbGroupInactiveArray = array_create(INPUT_MAX_PLAYERS, 0x00);
        
        //Define verb groups
        __InputVerbGroupsConfig();
        
        //Set up the plug-in itself and hook into the library as a whole
        InputPlugInDefine("InputTeam.VerbGroups", "Input Team", "1.0", "10.0", function()
        {
            InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.COLLECT_PLAYER, undefined, function(_playerIndex)
            {
                static _verbGroupLookupArray   = __InputVerbGroupSystem().__verbGroupLookupArray;
                static _verbGroupInactiveArray = __InputVerbGroupSystem().__verbGroupInactiveArray;
                
                //Get the bitmask for inactive verb groups
                var _inactiveBitmask = _verbGroupInactiveArray[_playerIndex];
                
                var _verbIndex = 0;
                repeat(array_length(_verbGroupLookupArray))
                {
                    if (INPUT_VERB_GROUP_INACTIVE_ON_ANY)
                    {
                        //Compare the verb group with the inactive bitmask. A verb is inactive if *any* of its verb groups
                        //are inactive
                        if (_verbGroupLookupArray[_verbIndex] & _inactiveBitmask)
                        {
                            InputPlugInVerbSet(_verbIndex, 0, 0, _playerIndex);
                        }
                    }
                    else
                    {
                        //Compare the verb group with the inactive bitmask. A verb is inactive if *all* of its verb groups
                        //are inactive
                        var _verbBitmask = _verbGroupLookupArray[_verbIndex];
                        if ((_verbBitmask & _inactiveBitmask) == _verbBitmask)
                        {
                            InputPlugInVerbSet(_verbIndex, 0, 0, _playerIndex);
                        }
                    }
                    
                    ++_verbIndex;
                }
            });
            });
        });
    }
    
    return _system;
}