// Feather disable all

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
        InputPlugInError($"Verb group index must be less than {__INPUT_MAX_VERB_GROUPS}");
    }
    
    //Iterate over every input verb ...
    var _i = 0;
    repeat(array_length(_verbArray))
    {
        //And poke a binary 1 into the bitmask for the verb
        _verbGroupLookupArray[_verbArray[_i]] |= (1 << _verbGroup);
        ++_i;
    }
}
