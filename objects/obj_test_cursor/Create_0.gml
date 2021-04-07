input_cursor_verbs(VERB.UP, VERB.DOWN, VERB.LEFT, VERB.RIGHT, 5);
input_cursor_move(room_width/2, room_height/2);

input_default_key(vk_left,  VERB.LEFT);
input_default_key(vk_right, VERB.RIGHT);
input_default_key(vk_up,    VERB.UP);
input_default_key(vk_down,  VERB.DOWN);

input_default_gamepad_axis(gp_axislh, true,  VERB.LEFT);
input_default_gamepad_axis(gp_axislh, false, VERB.RIGHT);
input_default_gamepad_axis(gp_axislv, true,  VERB.UP);
input_default_gamepad_axis(gp_axislv, false, VERB.DOWN);

input_default_gamepad_button(gp_padl, VERB.LEFT,  1);
input_default_gamepad_button(gp_padr, VERB.RIGHT, 1);
input_default_gamepad_button(gp_padu, VERB.UP,    1);
input_default_gamepad_button(gp_padd, VERB.DOWN,  1);

input_player_source_set(INPUT_SOURCE.KEYBOARD_AND_MOUSE);