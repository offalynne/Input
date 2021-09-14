draw_set_halign(fa_center);
draw_set_valign(fa_middle);

//Draw grid
var _cell_gap = 5;
var _cell     = 0;
var _iy = 0;
repeat(cell_split) //column
{
    var _ix = 0;
    repeat(cell_split) //row
    {
        //draw cell
        draw_set_color(c_white);
        draw_set_alpha(1/10);
        
        //highlight
        if (cell_tapped == _cell) 
            draw_set_alpha(1/5);

        draw_rectangle(_ix * cell_w, _iy * cell_h, (_ix + 1) * cell_w - _cell_gap, (_iy + 1) * cell_h - _cell_gap, false);
        
        //draw label
        draw_set_alpha(1);
        draw_text((_ix + 0.5) * cell_w, (_iy + 0.5) * cell_h, string(cell_taps[_cell]));

        ++_cell;
        ++_ix;
    }
    
    ++_iy;
}