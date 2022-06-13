var _string = "";
_string += concat("Player 0 connected = ", input_player_connected(),  ", keyboard = ", input_source_using(INPUT_KEYBOARD),    ", mouse = ", input_source_using(INPUT_MOUSE),    ", gamepad = ", input_player_get_gamepad(),  ", type = ", input_player_get_gamepad_type(),  "\n");
_string += concat("Player 1 connected = ", input_player_connected(1), ", keyboard = ", input_source_using(INPUT_KEYBOARD, 1), ", mouse = ", input_source_using(INPUT_MOUSE, 1), ", gamepad = ", input_player_get_gamepad(1), ", type = ", input_player_get_gamepad_type(1), "\n");
_string += concat("Player 2 connected = ", input_player_connected(2), ", keyboard = ", input_source_using(INPUT_KEYBOARD, 2), ", mouse = ", input_source_using(INPUT_MOUSE, 2), ", gamepad = ", input_player_get_gamepad(2), ", type = ", input_player_get_gamepad_type(2), "\n");
_string += concat("Players connected = ", input_player_connected_count(), "\n");
_string += concat("\n");
_string += concat("Player 0 2D = ", input_xy("left", "right", "up", "down"),    "\n");
_string += concat("Player 1 2D = ", input_xy("left", "right", "up", "down", 1), "\n");
_string += concat("Player 2 2D = ", input_xy("left", "right", "up", "down", 2), "\n");

draw_text(10, 10, _string);