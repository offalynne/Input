// Feather disable all

/// Must be called from within a INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER callback.
/// 
/// @param buffer
/// @param [playerIndex=0]

function InputPlugInVerbStateRead(_buffer, _playerIndex = 0)
{
    static _system = __InputSystem();
    static _playerArray = __InputSystemPlayerArray();
    
    __INPUT_VALIDATE_PLAYER_INDEX
    
    if (_system.__plugInCurrentCallback != INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER)
    {
        __InputError("Cannot call InputPlugInVerbStateRead() outside of a INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER callback");
    }
    
    var _frame = _system.__frame;
    
    var _header = buffer_read(_buffer, buffer_string);
    if (_header != __INPUT_VERB_STATE_HEADER)
    {
        __InputError("Header mismatch (expecting \"", __INPUT_VERB_STATE_HEADER, "\", got \"", _header, "\"");
    }
    
    var _verbCount = buffer_read(_buffer, buffer_u16);
    if (_verbCount != InputVerbCount())
    {
        __InputError("Verb count mismatch (expecting \"", InputVerbCount(), "\", got \"", _verbCount, "\"");
    }
    
    var _verbStateArray = _playerArray[_playerIndex].__verbStateArray;
    var _i = 0;
    repeat(_verbCount)
    {
        with(_verbStateArray[_i])
        {
            __prevHeld   = buffer_read(_buffer, buffer_bool);
            __valueRaw   = buffer_read(_buffer, buffer_f32);
            __valueClamp = buffer_read(_buffer, buffer_f32);
            __pressFrame = _frame - buffer_read(_buffer, buffer_s32);
            
            __held = (__valueClamp > 0);
        }
        
        ++_i;
    }
    
    var _footer = buffer_read(_buffer, buffer_string);
    if (_footer != __INPUT_VERB_STATE_FOOTER)
    {
        __InputError("Footer mismatch (expecting \"", __INPUT_VERB_STATE_FOOTER, "\", got \"", _footer, "\"");
    }
}