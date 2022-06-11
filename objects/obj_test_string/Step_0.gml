var _keyboard_string = input_keyboard_string_frame();

//Update string
test_string = string_insert(_keyboard_string, test_string, caret_position + 1);

//Update caret
caret_position += string_length(_keyboard_string); 

//Move caret
caret_position += input_keyboard_check_pressed(vk_right) - input_keyboard_check_pressed(vk_left); 

if (input_keyboard_check_pressed(vk_delete))
{
    //Remove character in front of caret
    test_string = string_delete(test_string, caret_position + 1, 1); 
}
else if (input_keyboard_check_pressed(vk_backspace)) 
{
    //Remove character behind caret
    test_string = string_delete(test_string, caret_position, 1);
    caret_position--;
}

//Clamp caret
caret_position = clamp(caret_position, 0, string_length(test_string));

blinker_tick++;
