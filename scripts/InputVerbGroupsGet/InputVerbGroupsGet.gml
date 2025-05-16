// Feather disable all

/// Returns an array that contains the verb group indexes that a verb is assigned to. If a verb is
/// assigned to no verb groups then this function returns an empty array.
/// 
/// @param verbIndex

function InputVerbGroupsGet(_verbIndex)
{
    static _verbGroupLookupArray = __InputVerbGroupSystem().__verbGroupLookupArray;
    
	static _groupArray = [];
	array_resize(_groupArray, 0);
    
    //Unpack binary 1s from the bitmask into an array
    var _bitmask = _verbGroupLookupArray[_verbIndex];
	var _i = 0;
	repeat(__INPUT_MAX_VERB_GROUPS)
	{
		if (_bitmask & (1 << _i))
		{
			array_push(_groupArray, _i);
		}
        
		++_i;
	}

	return _groupArray;
}