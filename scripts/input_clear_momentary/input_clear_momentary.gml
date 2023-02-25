/// @desc    Clears momentary (pressed/released) input and connection checkers
///          This covers verbs as well as keyboard/mouse/gamepad direct checkers
/// @param   state

function input_clear_momentary(_state)
{
    __INPUT_GLOBAL_STATIC_LOCAL
    
    global.__input_cleared = _state;
}