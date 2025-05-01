// Feather disable all

/// Returns an array of verb states which are copies of the current verb state in the library. This
/// is useful for interrogating verb history for e.g. a combo system. The verb states are structs
/// that contain the following values:
/// 
/// - `.prevHeld`   Whether the verb was held in the previous frame
/// - `.held`       Whether the verb is held on this frame
/// - `.valueRaw`   Raw analogue value
/// - `.valueClamp` Analogue value after remapping and clamping
/// - `.duration`   Number of frames since the verb was pressed
/// 
/// @param [newArray=true]
/// @param [playerIndex=0]

function InputVerbStateArray(_newArray = true, _playerIndex = 0)
{
    static _system = __InputSystem();
    static _playerArray = __InputSystemPlayerArray();
    static _funcGenerate = function()
    {
        return {
            prevHeld:   false,
            held:       false,
            valueRaw:   0,
            valueClamp: 0,
            duration:   infinity,
        };
    }
    
    static _staticArray = array_create_ext(InputVerbCount(), _funcGenerate);
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    if (_newArray)
    {
        var _targetArray = array_create_ext(InputVerbCount(), _funcGenerate);
    }
    else
    {
        var _targetArray = _staticArray;
    }
    
    var _frame = _system.__frame;
    
    var _verbStateArray = _playerArray[_playerIndex].__verbStateArray;
    var _i = 0;
    repeat(array_length(_targetArray))
    {
        var _targetStruct = _targetArray[_i];
        with(_verbStateArray[_i])
        {
            _targetStruct.prevHeld   = __prevHeld;
            _targetStruct.held       = __held;
            _targetStruct.valueRaw   = __valueRaw;
            _targetStruct.valueClamp = __valueClamp;
            _targetStruct.duration   = _frame - __pressFrame;
        }
        
        ++_i;
    }
}