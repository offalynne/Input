input_cursor_verbs(VERB.UP, VERB.DOWN, VERB.LEFT, VERB.RIGHT, 5);
input_cursor_move(room_width/2, room_height/2);

input_default_key(vk_left,  VERB.LEFT);
input_default_key(vk_right, VERB.RIGHT);
input_default_key(vk_up,    VERB.UP);
input_default_key(vk_down,  VERB.DOWN);

input_player_source_set(INPUT_SOURCE.KEYBOARD_AND_MOUSE);