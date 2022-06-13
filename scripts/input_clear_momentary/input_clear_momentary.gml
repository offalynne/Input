/// @desc    Clears momentary (pressed/released) input and connection checkers
///          This covers verbs as well as keyboard/mouse/gamepad direct checkers
/// @param   state

function input_clear_momentary(_state)
{
    global.__input_cleared = _state;
}