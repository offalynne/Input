input_tick();
input_hotswap_tick();

if (input_keyboard_check_pressed(vk_enter) || input_gamepad_check_pressed(0, gp_start)) rebinding = true;

if (input_keyboard_check_pressed(ord("S")))
{
    rebinding = false;
    
    var _string = input_bindings_write();
    var _buffer = buffer_create(string_byte_length(_string)+1, buffer_grow, 1);
    buffer_write(_buffer, buffer_string, _string);
    buffer_save(_buffer, "test_saveload.json");
    buffer_delete(_buffer);
    
    show_debug_message("Saved!");
}

if (input_keyboard_check_pressed(ord("L")))
{
    rebinding = false;
    
    var _buffer = buffer_load("test_saveload.json");
    var _string = buffer_read(_buffer, buffer_string);
    buffer_delete(_buffer);
    input_bindings_read(_string);
    
    show_debug_message("Loaded!");
}

if (input_keyboard_check_pressed(ord("R")))
{
    rebinding = false;
    
    input_bindings_reset(all);
    
    show_debug_message("Reset!");
}

if (rebinding)
{
    if (input_rebind_tick(VERB.LEFT) != 0) rebinding = false;
}