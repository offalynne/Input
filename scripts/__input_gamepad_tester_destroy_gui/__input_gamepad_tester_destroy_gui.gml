//Feather disable all

function __input_gamepad_tester_destroy_gui()
{
    __INPUT_GLOBAL_STATIC_LOCAL
    
    var _view = _global.__gamepad_tester_data.__view_pointer;
    if (_view != undefined)
    {
        dbg_view_delete(_view);
        _global.__gamepad_tester_data.__view_pointer = undefined;
    }
}