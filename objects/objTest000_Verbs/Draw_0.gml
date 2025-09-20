var _string = "";
_string += "General purpose verb tester";

repeat((current_time mod 599) div 150)
{
    _string += ".";
}

_string += "\n";
_string += InputDeviceGetDescription(InputPlayerGetDevice()) + "\n";

if (keyboard_check(vk_anykey))
{
    _string += "(keyboard input)\n";
}

if (mouse_check_button(mb_any))
{
    _string += "(mouse input)\n";
}

draw_text(10, 10, _string);

_string = "";

var _i = 0;
repeat(InputVerbCount())
{
    if (InputCheck(_i)) _string += string_concat("Holding ", InputVerbGetExportName(_i), "\n");
    ++_i;
}

draw_text(10, 110, _string);

var _string = "";
var _i = 0;
repeat(InputVerbCount())
{
    if (InputValue(_i) != 0) _string += string_concat(InputVerbGetExportName(_i), " = ", InputValue(_i), "\n");
    ++_i;
}

draw_text(300, 10, _string);

draw_text(10, 300, string_join_ext("\n", eventArray, 0, 30));

_string = "";

var _i = 32;
repeat(100)
{
    if (keyboard_check(_i))
    {
        _string += InputGetBindingName(_i, false) + "\n";
    }
    
    ++_i;
}

draw_text(200, 110, _string);