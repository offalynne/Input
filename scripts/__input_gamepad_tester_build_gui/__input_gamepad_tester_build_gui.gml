//Feather disable all

function __input_gamepad_tester_build_gui()
{
    __INPUT_GLOBAL_STATIC_LOCAL
    
    with(_global.__gamepad_tester_data)
    {
        var _width  = 320;
        var _height = min(window_get_height() - 100, 800);
        
        __view_pointer = dbg_view("Input Gamepad Tester", true, 0.5*(window_get_width() - _width), 0.5*(window_get_height() - _height), _width, _height);
        
        dbg_section("Control");
        dbg_text_input(_global.__gamepad_tester_data.__gamepad_ref, "Gamepad");
        dbg_text(_global.__gamepad_tester_data.__gamepad_desc_ref);
        dbg_checkbox(_global.__gamepad_tester_data.__block_input_ref, "Debug blocks input");
        dbg_button("Close", function()
        {
            input_gamepad_tester_set(false);
        });
        
        dbg_section("Input (via SDL)");
        var _i = 0;
        repeat(array_length(__input_ref_array))
        {
            var _label = __binding_name_array[_i];
            repeat(13 - string_length(_label)) _label += " ";
            _label += " = ";
            
            dbg_text(_label);
            dbg_same_line();
            dbg_text(__input_ref_array[_i]);
            
            ++_i;
        }
        
        dbg_section("GameMaker Native");
        var _i = 0;
        repeat(array_length(__gml_ref_array))
        {
            var _label = __binding_name_array[_i];
            repeat(13 - string_length(_label)) _label += " ";
            _label += " = ";
            
            dbg_text(_label);
            dbg_same_line();
            dbg_text(__gml_ref_array[_i]);
            
            ++_i;
        }
        
        dbg_section("Raw");
        dbg_text(__raw_input_string_ref);
    }
}