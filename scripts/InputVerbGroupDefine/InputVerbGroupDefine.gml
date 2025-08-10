// Feather disable all

/// Defines a verb group and assigns verbs to it. A verb may be assigned to multiple verb groups.
/// This function should only be called in the `__InputVerbGroupsConfig()` script. Assigning a
/// verb to a verb group enables a few things:
/// 
/// 1. Verbs in a verb group can be deactivated en masse by calling `InputVerbGroupSetActive()`.
///    Deactivated verbs will have their raw value set to 0. If the verb is currently active (e.g.
///    a player is holding down a keyboard key) then the verb will be considered "released" for a
///    single frame after the verb group has been deactivated.
/// 
/// 2. Verbs that have the same binding would normally be considered as colliding for the purposes
///    of `InputBindingSetSafe()`. However, if two verbs share a binding but are in different verb
///    groups then they will instead not collide. For example, if one verb in is the "gameplay"
///    verb group and it shares a binding with a verb in the "menu" verb group then they won't
///    collide.
/// 
/// N.B. If a verb has not been assigned to any verb group then it will be treated as though it is
///      in every verb group for finding collisions.
/// 
/// @param verbGroupIndex
/// @param verbArray

function InputVerbGroupDefine(_verbGroup, _verbArray)
{
    static _verbGroupLookupArray = __InputVerbGroupSystem().__verbGroupLookupArray;
    
    if (_verbGroup < 0)
    {
        InputPlugInError("Verb group index must be greater than 0");
    }
    
    if (_verbGroup >= __INPUT_MAX_VERB_GROUPS)
    {
        InputPlugInError("Verb group index must be less than ", __INPUT_MAX_VERB_GROUPS);
    }
    
    //Iterate over every input verb ...
    var _i = 0;
    repeat(array_length(_verbArray))
    {
        //And poke a binary 1 into the bitmask for the verb
        _verbGroupLookupArray[@ _verbArray[_i]] |= (1 << _verbGroup);
        ++_i;
    }
}
