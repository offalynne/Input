if (input_keyboard_check_pressed(vk_enter)
||  input_gamepad_check_pressed(input_player_get_gamepad(), gp_start))
{
    input_binding_scan_start(function(_binding)
    {
        input_binding_set_safe("left", _binding);
    });
}

if (input_keyboard_check_pressed(ord("C")))
{
    input_binding_set("left", input_binding_empty());
    show_debug_message("Clear!");
}

if (input_keyboard_check_pressed(ord("S")))
{
    input_binding_scan_abort();
    
    var _string = input_system_export(true, true);
    var _buffer = buffer_create(string_byte_length(_string), buffer_grow, 1);
    buffer_write(_buffer, buffer_text, _string);
    buffer_save(_buffer, "test_saveload.json");
    buffer_delete(_buffer);
    
    show_debug_message("Saved!");
}

if (input_keyboard_check_pressed(ord("L")))
{
    input_binding_scan_abort();
    
    var _buffer = buffer_load("test_saveload.json");
    var _string = buffer_read(_buffer, buffer_text);
    buffer_delete(_buffer);
    input_system_import(_string);
    
    show_debug_message("Loaded!");
}

if (input_keyboard_check_pressed(ord("R")))
{
    input_binding_scan_abort();
    input_system_reset();
    show_debug_message("Reset!");
}