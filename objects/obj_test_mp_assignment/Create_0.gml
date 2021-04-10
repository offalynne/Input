input_default_key(vk_left,   VERB.LEFT   );
input_default_key(vk_right,  VERB.RIGHT  );
input_default_key(vk_up,     VERB.UP     );
input_default_key(vk_down,   VERB.DOWN   );
input_default_key(vk_escape, VERB.CANCEL );
input_default_key(vk_space,  VERB.CONFIRM);

input_default_gamepad_axis(gp_axislh, true,  VERB.LEFT );
input_default_gamepad_axis(gp_axislh, false, VERB.RIGHT);
input_default_gamepad_axis(gp_axislv, true,  VERB.UP   );
input_default_gamepad_axis(gp_axislv, false, VERB.DOWN );
input_default_gamepad_button(gp_padl, VERB.LEFT,  1);
input_default_gamepad_button(gp_padr, VERB.RIGHT, 1);
input_default_gamepad_button(gp_padu, VERB.UP,    1);
input_default_gamepad_button(gp_padd, VERB.DOWN,  1);

input_default_gamepad_button(gp_face1, VERB.CONFIRM);
input_default_gamepad_button(gp_face2, VERB.CANCEL );

//input_player_source_set(INPUT_SOURCE.KEYBOARD_AND_MOUSE, 0);
//input_player_source_set(INPUT_SOURCE.GAMEPAD, 1);
//input_player_source_set(INPUT_SOURCE.GAMEPAD, 2);
//
//input_player_gamepad_set(0, 1);
//input_player_gamepad_set(1, 2);

all_assigned = false;