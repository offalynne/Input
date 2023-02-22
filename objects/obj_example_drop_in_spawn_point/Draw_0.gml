draw_set_alpha(0.3);
draw_circle(x, y, 16, false);
draw_set_alpha(1);

draw_set_colour(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(0.5);
draw_text(x, y, "P" + string(player+1));
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);