//Feather disable all

input_virtual_debug_draw();

var _string = concat(
    "accept    = ", input_value("accept"), ", check = ", input_check("accept"), "\n",
    "right     = ", input_value("right" ), ", check = ", input_check("right" ), "\n",
    "up        = ", input_value("up"    ), ", check = ", input_check("up"    ), "\n",
    "left      = ", input_value("left"  ), ", check = ", input_check("left"  ), "\n",
    "down      = ", input_value("down"  ), ", check = ", input_check("down"  ), "\n",
    "type      = ", pressed_vbutton_type(), "\n",
    "momentary = ", i.get_momentary()? "ON\n" : "off\n",
);

var _func_draw_arrow = function(_x1, _y1, _x2, _y2)
{
    draw_set_colour(c_black);
    draw_arrow(_x1-1, _y1-1, _x2-1, _y2-1, 30);
    draw_arrow(_x1+1, _y1-1, _x2+1, _y2-1, 30);
    draw_arrow(_x1-1, _y1+1, _x2-1, _y2+1, 30);
    draw_arrow(_x1+1, _y1+1, _x2+1, _y2+1, 30);
    draw_set_colour(c_white);
    draw_arrow(_x1, _y1, _x2, _y2, 30);
}

var _position = c.get_position();
_func_draw_arrow(_position.__x, _position.__y, _position.__x + 100*c.get_x(), _position.__y + 100*c.get_y());

_func_draw_arrow(_position.__x, _position.__y, _position.__x + 100*input_value("right"), _position.__y);
_func_draw_arrow(_position.__x, _position.__y, _position.__x, _position.__y - 100*input_value("up"));
_func_draw_arrow(_position.__x, _position.__y, _position.__x - 100*input_value("left"), _position.__y);
_func_draw_arrow(_position.__x, _position.__y, _position.__x, _position.__y + 100*input_value("down"));

draw_text(10, 10, _string);

draw_circle(test_x, test_y, 30, false);