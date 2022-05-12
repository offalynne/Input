if (input_keyboard_check_pressed(vk_enter)
||  input_gamepad_check_pressed(input_player_get_gamepad(), gp_start))
{
    rebinding = true;
}

if (input_keyboard_check_pressed(ord("S")))
{
    rebinding = false;
    
    var _string = input_binding_system_write();
    var _buffer = buffer_create(string_byte_length(_string), buffer_grow, 1);
    buffer_write(_buffer, buffer_text, _string);
    buffer_save(_buffer, "test_saveload.json");
    buffer_delete(_buffer);
    
    show_debug_message("Saved!");
}

if (input_keyboard_check_pressed(ord("L")))
{
    rebinding = false;
    
    var _buffer = buffer_load("test_saveload.json");
    var _string = buffer_read(_buffer, buffer_text);
    buffer_delete(_buffer);
    input_binding_system_read(_string);
    
    show_debug_message("Loaded!");
}

if (input_keyboard_check_pressed(ord("R")))
{
    rebinding = false;
    
    input_binding_system_reset(all);
    
    show_debug_message("Reset!");
}

if (rebinding)
{
    var _binding = input_binding_scan_tick();
    if (_binding != undefined)
    {
        input_binding_set_safe("left", _binding);
        rebinding = false;
    }
}