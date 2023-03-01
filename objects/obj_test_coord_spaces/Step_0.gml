if (keyboard_check_pressed(ord("1")))
{
    coord_space = INPUT_COORD_SPACE.ROOM;
    input_cursor_coord_space_set(coord_space);
    input_mouse_coord_space_set(coord_space);
}

if (keyboard_check_pressed(ord("2")))
{
    coord_space = INPUT_COORD_SPACE.GUI;
    input_cursor_coord_space_set(coord_space);
    input_mouse_coord_space_set(coord_space);
}

if (keyboard_check_pressed(ord("3")))
{
    coord_space = INPUT_COORD_SPACE.DEVICE;
    input_cursor_coord_space_set(coord_space);
    input_mouse_coord_space_set(coord_space);
}

if (input_check_double_pressed("shoot"))
{
    coord_space = (coord_space + 1) mod 3;
    input_mouse_coord_space_set(coord_space);
}