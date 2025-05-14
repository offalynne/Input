// Feather disable all

/// @param verbGroupIndex

function InputVerbGroupGetVerbs(_verbGroupIndex)
{
    static _verbGroupLookupArray = __InputVerbGroupSystem().__verbGroupLookupArray;
    
	static _verbArray = [];
	array_resize(_verbArray, 0);
    
    //Find verbs whose verb group bitmask overlaps with the given verb group
    var _bitmask = (1 << _verbGroupIndex);
	var _i = 0;
	repeat(array_length(_verbGroupLookupArray))
	{
		if (_bitmask & (1 << _i))
		{
			array_push(_verbArray, _i);
		}
        
		++_i;
	}

	return _verbArray;
}