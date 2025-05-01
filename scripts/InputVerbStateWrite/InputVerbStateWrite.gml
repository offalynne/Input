// Feather disable all

/// Writes the current verb state into a buffer. Four values are written:
/// 
/// - `buffer_bool`  Whether the verb was held in the previous frame
/// - `buffer_f32`   Raw analogue value
/// - `buffer_f32`   Analogue value after remapping and clamping
/// - `buffer_s32`   Number of frames since the verb was pressed
/// 
/// The verb state is preceded by the string "<-PWP" and ends with the string ">". Verb state can
/// be restored by calling `InputPlugInVerbStateRead()` (but this read function must be called
/// in a `INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER` callback).
/// 
/// @param buffer
/// @param [playerIndex=0]

function InputVerbStateWrite(_buffer, _playerIndex = 0)
{
    static _system = __InputSystem();
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    var _frame = _system.__frame;
    var _verbCount = InputVerbCount();
    
    buffer_write(_buffer, buffer_string, __INPUT_VERB_STATE_HEADER);
    buffer_write(_buffer, buffer_u16, _verbCount);
    
    var _verbStateArray = _playerArray[_playerIndex].__verbStateArray;
    var _i = 0;
    repeat(_verbCount)
    {
        with(_verbStateArray[_i])
        {
            buffer_write(_buffer, buffer_bool, __prevHeld);
            buffer_write(_buffer, buffer_f32,  __valueRaw);
            buffer_write(_buffer, buffer_f32,  __valueClamp);
            buffer_write(_buffer, buffer_s32,  _frame - __pressFrame);
        }
        
        ++_i;
    }
    
    buffer_write(_buffer, buffer_string, __INPUT_VERB_STATE_FOOTER);
}