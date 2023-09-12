//Feather disable all

function __input_gamepad_tester_tick()
{
    __INPUT_GLOBAL_STATIC_LOCAL
    
    with(_global.__gamepad_tester_data)
    {
        try
        {
            var _gamepad = real(__target_gamepad);
        }
        catch(_error)
        {
            var _gamepad = 0;
        }   
        
        __gamepad_desc = "Description = \"" + string(input_gamepad_get_description(_gamepad)) + "\"";
        
        //Input values dictionary
        var _i = 0;
        repeat(array_length(__input_binding_array))
        {
            var _binding = __input_binding_array[_i];
            if (input_gamepad_is_axis(_gamepad, _binding))
            {
                __input_values[$ __binding_name_array[_i]] = string_format(__input_gamepad_value_internal(_gamepad, _binding), 2, 2);
            }
            else
            {
                __input_values[$ __binding_name_array[_i]] = string_format(__input_gamepad_value_internal(_gamepad, _binding), 2, 0) + "  ";
            }
        
            ++_i;
        }
        
        //GML values dictionary
        var _i = 0;
        repeat(array_length(__gml_binding_array))
        {
            var _binding = __gml_binding_array[_i];
            if ((_binding == gp_axislh) || (_binding == gp_axislv) || (_binding == gp_axisrh) || (_binding == gp_axisrv))
            {
                __gml_values[$ __binding_name_array[_i]] = string_format(gamepad_axis_value(_gamepad, _binding), 2, 2);
            }
            else
            {
                __gml_values[$ __binding_name_array[_i]] = string_format(gamepad_button_check(_gamepad, _binding), 2, 0) + "  ";
            }
        
            ++_i;
        }
        
        //Check raw values from the gamepad
        var _string = "";
    
        var _i = 0;
        repeat(12)
        {
            _string += "axis " + string_format(_i, 4, 0) + " = " + string_format(gamepad_axis_value(_gamepad, _i), 2, 2) + "\n";
            ++_i;
        }
    
        _string += "axis 4106 = " + string_format(gamepad_axis_value(_gamepad, 4106), 2, 2) + " (XInput)\n";
        _string += "axis 4107 = " + string_format(gamepad_axis_value(_gamepad, 4107), 2, 2) + " (XInput)\n";
    
        var _i = 0;
        repeat(40)
        {
            if (gamepad_button_check(_gamepad, _i)) _string += "button " + string(_i) + "\n";
            ++_i;
        }
    
        var _i = 0;
        repeat(10)
        {
            if (gamepad_hat_value(_gamepad, _i)) _string += "hat " + string(_i) + "\n";
            ++_i;
        }
        
        //Extra padding at the bottom
        repeat(20) _string += "\n";
        __raw_input_string = _string;
    }
}