var _string = "";
var _i = 0;
repeat(InputVerbCount())
{
    if (InputCheck(_i)) _string += string_concat("Holding ", InputVerbGetExportName(_i), "\n");
    ++_i;
}

draw_text(10, 10, _string);

var _string = "";
var _i = 0;
repeat(InputVerbCount())
{
    if (InputValue(_i) != 0) _string += string_concat(InputVerbGetExportName(_i), " = ", InputValue(_i), "\n");
    ++_i;
}

draw_text(300, 10, _string);

draw_text(10, 300, string_join_ext("\n", eventArray, 0, 30));