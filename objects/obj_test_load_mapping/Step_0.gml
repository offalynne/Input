input_tick();
input_source_hotswap_tick();

if (keyboard_check_pressed(ord("L")))
{
    var _buffer = buffer_load("test_load_mapping.json");
    var _string = buffer_read(_buffer, buffer_text);
    buffer_delete(_buffer);
    
    input_binding_system_read(_string);
}