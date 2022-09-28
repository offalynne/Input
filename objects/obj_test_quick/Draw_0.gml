//Draw a dash trail!
if (quick)
{
    draw_set_alpha(0.3);
    draw_set_colour(c_orange);
    
    var _i = 1;
    repeat(3)
    {
        draw_circle(x + _i*(xprevious - x), y + _i*(yprevious - y), 25 - _i, false);
        ++_i;
    }
    
    draw_set_alpha(1.0);
    draw_set_colour(c_white);
}

draw_circle(x, y, 25, false);
