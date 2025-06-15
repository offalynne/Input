// Feather disable all

/// Compares two version strings and returns if the actual version meets the required target
/// version. Version numbers should be strings and should fit the format `major.minor`. This
/// function will return `true` if the following two conditions are met:
/// 
/// 1. The major versions match exactly
/// 2. The minor target version is less than or equal to the actual minor version
/// 
/// @param targetVersion
/// @param actualVersion

/*
//Unit tests!

//Nonsense and nonsense
__InputTrace("Test 1: Expect 1, got ", __InputCompareVersions("afoweijhwefioj", "Wefiolwjhefiojwe"));

//Nonsense and a proper version
__InputTrace("Test 2: Expect 0, got ", __InputCompareVersions("afoweijhwefioj", INPUT_VERSION));

//Matching versions
__InputTrace("Test 3: Expect 1, got ", __InputCompareVersions("10.0", "10.0"));

//Self-test against current `INPUT_VERSION`
__InputTrace("Test 4: Expect 1, got ", __InputCompareVersions(INPUT_VERSION, INPUT_VERSION));

//Minor version too high
__InputTrace("Test 5: Expect 0, got ", __InputCompareVersions("10.1", "10.0"));

//Major version mismatch
__InputTrace("Test 6: Expect 0, got ", __InputCompareVersions( "9.0", "10.0"));

//Major version mismatch
__InputTrace("Test 7: Expect 0, got ", __InputCompareVersions("11.0", "10.0"));

//Double failure!
__InputTrace("Test 8: Expect 0, got ", __InputCompareVersions("11.3", "10.0"));

//Minor version low but that's ok
__InputTrace("Test 9: Expect 1, got ", __InputCompareVersions("10.11", "10.13"));

//Too much detail but we handle it
__InputTrace("Test 10: Expect 1, got ", __InputCompareVersions("1.1.1", "1.2.1"));

__InputTrace("Done!");
//*/


function __InputCompareVersions(_targetVersion, _actualVersion)
{
    _targetVersion = string(_targetVersion);
    _actualVersion = string(_actualVersion);
    
    static _funcSplit = function(_versionString)
    {
        static _array = [];
        array_resize(_array, 0);
        
        static _funcSafeReal = function(_string)
        {
            if (_string == "") return 0;
            
            try
            {
                var _value = real(_string);
            }
            catch(_error)
            {
                var _value = 0;
            }
            
            return _value;
        }
        
        var _struct = {
            __major: 0,
            __minor: 0,
        };
        
        //Break down the string whilst also filtering out non-numeric characters (and period .)
        string_foreach(_versionString, method({
            __array: _array,
        },
        function(_char)
        {
            var _ord = ord(_char);
            if (((_ord >= 48) && (_ord <= 57)) || (_ord == 46))
            {
                array_push(__array, _char);
            }
        }));
        
        //Find the major version - it's the number before the first dot
        var _firstDotIndex = array_get_index(_array, ".");
        if (_firstDotIndex < 0)
        {
            //If there's no dot then the whole thing is a version!
            _struct.__major = _funcSafeReal(string_concat_ext(_array));
        }
        else
        {
            _struct.__major = _funcSafeReal(string_concat_ext(_array, 0, _firstDotIndex));
            
            var _secondDotIndex = array_get_index(_array, ".", _firstDotIndex + 1);
            if (_secondDotIndex < _firstDotIndex)
            {
                _struct.__minor = _funcSafeReal(string_concat_ext(_array, _firstDotIndex+1));
            }
            else
            {
                _struct.__minor = _funcSafeReal(string_concat_ext(_array, _firstDotIndex+1, _secondDotIndex - _firstDotIndex - 1));
            }
        }
        
        array_resize(_array, 0);
        
        return _struct;
    }
    
    var _targetStruct = _funcSplit(_targetVersion);
    var _actualStruct = _funcSplit(_actualVersion);
    
    if (_targetStruct.__major != _actualStruct.__major) return false;
    if (_targetStruct.__minor >  _actualStruct.__minor) return false;
    
    return true;
}