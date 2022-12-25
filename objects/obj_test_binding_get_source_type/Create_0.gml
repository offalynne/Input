last_message = "Press any key/button";

success_function = function(_new_binding)
{
    last_message = "New binding:"
                 + "\n\n" + input_binding_get_name(_new_binding)
                 + "\n\n" + input_binding_get_icon(_new_binding)
                 + "\n\n" + string(input_binding_get_source_type(_new_binding))
                 + "\n\n" + string(_new_binding);
    
    //wow so meta
    input_binding_scan_start(obj_test_binding_get_source_type.success_function, obj_test_binding_get_source_type.fail_function);
}

fail_function = function(_error_code)
{
    last_message =  "Failed:\n" + string(_error_code);
    
    //wow so meta
    input_binding_scan_start(obj_test_binding_get_source_type.success_function, obj_test_binding_get_source_type.fail_function);
}

input_binding_scan_start(success_function, fail_function);