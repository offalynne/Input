/// @param verbUp
/// @param verbDown
/// @param verbLeft
/// @param verbRight
/// @param speed

function input_cursor_verbs(_up, _down, _left, _right, _speed)
{
    if (INPUT_WARNING_DEPRECATED) __input_error("This function has been deprecated\n(Set INPUT_WARNING_DEPRECATED to <false> to ignore this warning)");
    
    global.__input_cursor_verb_u = _up;
    global.__input_cursor_verb_d = _down;
    global.__input_cursor_verb_l = _left;
    global.__input_cursor_verb_r = _right;
    global.__input_cursor_speed  = _speed;
}