input_tick();

if (keyboard_check_pressed(ord("1"))) input_cursor_translate(room_width/2, room_height/2, 60);
if (keyboard_check_pressed(ord("2"))) input_cursor_translate(   undefined, room_height/2, 60);
if (keyboard_check_pressed(ord("3"))) input_cursor_translate(room_width/2,     undefined, 60);
if (keyboard_check_pressed(ord("4"))) input_cursor_translate(  room_width,   room_height, 60);
