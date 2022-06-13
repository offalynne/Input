//Choose a nice clear colour for the aiming reticule
draw_set_colour(c_fuchsia);

if (input_source_using(INPUT_GAMEPAD, player))
{
    //If we're using a gamepad, draw the reticule a fixed distance away from the player
    //This feels a bit nicer than following the cursor exactly
    draw_circle(x + lengthdir_x(130, aim_direction), y + lengthdir_y(130, aim_direction), 6, true);
}
else
{
    //When aiming using the mouse then we'll draw the reticule exactly on the cursor
    draw_circle(input_cursor_x(player), input_cursor_y(player), 6, true);
}

draw_set_colour(c_white);