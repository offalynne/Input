var _string = "";
var _array = input_history_get();
var _i = 0;
repeat(array_length(_array))
{
    _string += string(_array[_i]) + "\n";
    ++_i;
}

draw_text(10, 10, _string);