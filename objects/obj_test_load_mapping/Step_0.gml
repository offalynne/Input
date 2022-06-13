if (keyboard_check_pressed(ord("L")))
{
    var _buffer = buffer_load("test_load_mapping.json");
    var _string = buffer_read(_buffer, buffer_text);
    buffer_delete(_buffer);
    
    input_system_export(_string);
}