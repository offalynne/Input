// Feather disable all

/// Returns the number of bytes that a verb state will occupy if `InputVerbStateWrite()` is
/// called. 

function InputVerbStateByteLength()
{
    static _length = InputVerbCount()*(string_byte_length(__INPUT_VERB_STATE_HEADER)+1
                                        + buffer_sizeof(buffer_bool)
                                        + buffer_sizeof(buffer_f32)
                                        + buffer_sizeof(buffer_f32)
                                        + buffer_sizeof(buffer_s32)
                                        + string_byte_length(__INPUT_VERB_STATE_FOOTER)+1);
    
    return _length;
}