//Feather disable all

/// Opens or closes the gamepad tester debug view
/// 
/// Please note that Input verb checker functions will not work when GameMaker's debug
/// overlay is open (by design)
/// 
/// @param state

function input_gamepad_tester_set(_state)
{
    __INPUT_GLOBAL_STATIC_LOCAL
    
    if (_global.__allow_gamepad_tester)
    {
        if (_global.__gamepad_tester_data.__enabled != _state)
        {
            if (_state)
            {
                __input_gamepad_tester_build_gui();
                _global.__gamepad_tester_data.__enabled = true;
            }
            else
            {
                __input_gamepad_tester_destroy_gui();
                _global.__gamepad_tester_data.__enabled = false;
            }
        }
    }
    else
    {
        __input_error("Gamepad tester not available on GameMaker versions before 2023.8");
    }
}