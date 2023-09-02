//Feather disable all

/// Returns whether the gamepad tester debug view is open

function input_gamepad_tester_get()
{
    __INPUT_GLOBAL_STATIC_LOCAL
    
    return (_global.__allow_gamepad_tester && _global.__gamepad_tester_data.__enabled);
}