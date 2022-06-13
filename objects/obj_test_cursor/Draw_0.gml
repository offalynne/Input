var _mouse_x = input_mouse_x();
var _mouse_y = input_mouse_y();
draw_triangle(_mouse_x, _mouse_y, _mouse_x - 10, _mouse_y + 20, _mouse_x + 10, _mouse_y + 20, true);

var _p = 0;
repeat(input_player_connected_count())
{
    draw_line(room_width/2, room_height/2, input_cursor_x(_p), input_cursor_y(_p));
    
    draw_circle(input_cursor_x(_p), input_cursor_y(_p), 16, true);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(input_cursor_x(_p), input_cursor_y(_p), _p);
    draw_set_halign(fa_left);
    draw_set_halign(fa_top);
    
    ++_p;
}