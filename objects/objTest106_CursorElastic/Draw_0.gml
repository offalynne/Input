//Feather disable all

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _i = 0;
repeat(INPUT_MAX_PLAYERS)
{
    if (InputPlayerIsConnected(_i))
    {
        var _x = InputCursorX(_i);
        var _y = InputCursorY(_i);
        draw_text(_x, _y, _i);
        draw_circle(_x, _y, 20, true);
    }
    
    ++_i;
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);