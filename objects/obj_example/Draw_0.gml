var _string  = "Left    = " + string(input_value(VERB.LEFT   )) + "    " + string(input_binding_get(VERB.LEFT   )) + "\n";
    _string += "Right   = " + string(input_value(VERB.RIGHT  )) + "    " + string(input_binding_get(VERB.RIGHT  )) + "\n";
    _string += "Up      = " + string(input_value(VERB.UP     )) + "    " + string(input_binding_get(VERB.UP     )) + "\n";
    _string += "Down    = " + string(input_value(VERB.DOWN   )) + "    " + string(input_binding_get(VERB.DOWN   )) + "\n";
    _string += "Confirm = " + string(input_value(VERB.CONFIRM)) + "    " + string(input_binding_get(VERB.CONFIRM)) + "\n";
    _string += "Cancel  = " + string(input_value(VERB.CANCEL )) + "    " + string(input_binding_get(VERB.CANCEL )) + "\n";
    _string += "Pause   = " + string(input_value(VERB.PAUSE  )) + "    " + string(input_binding_get(VERB.PAUSE  )) + "\n";

//var _gamepad = input_player_gamepad_get(0);
//var _i = 0;
//repeat(30)
//{
//    if (gamepad_button_check(_gamepad, _i))
//    {
//        _string += "b" + string(_i) + "\n";
//    }
//    
//    ++_i;
//}
//
//var _i = 0;
//repeat(10)
//{
//    _string += "a" + string(_i) + " = " + string(gamepad_axis_value(_gamepad, _i)) + "\n";
//    ++_i;
//}
//
//_string += "a4106 = " + string(gamepad_axis_value(_gamepad, 4106)) + "\n";
//_string += "a4107 = " + string(gamepad_axis_value(_gamepad, 4107)) + "\n";

draw_text(10, 10, _string);

var _i = 0;
repeat(INPUT_MAX_PLAYERS)
{
    if (input_player_connected(_i))
    {
        var _x = input_cursor_x(_i);
        var _y = input_cursor_y(_i);
        
        draw_circle(_x, _y, 4, false);
        draw_circle(_x, _y, 6, true);
        draw_text(_x + 5, _y + 5, _i);
    }
    
    ++_i;
}