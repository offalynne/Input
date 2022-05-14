if (keyboard_check_pressed(ord("1"))) input_player_ghost_set(!input_player_ghost_get());
if (keyboard_check_pressed(ord("2"))) input_player_ghost_set(!input_player_ghost_get(1), 1);
if (keyboard_check_pressed(ord("3"))) input_player_ghost_set(!input_player_ghost_get(2), 2);