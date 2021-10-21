input_default_key(vk_left,   "left"   );
input_default_key(vk_right,  "right"  );
input_default_key(vk_up,     "up"     );
input_default_key(vk_down,   "down"   );
input_default_key(vk_escape, "cancel" );
input_default_key(vk_space,  "confirm");

input_default_gamepad_axis(gp_axislh, true,  "left" );
input_default_gamepad_axis(gp_axislh, false, "right");
input_default_gamepad_axis(gp_axislv, true,  "up"   );
input_default_gamepad_axis(gp_axislv, false, "down" );
input_default_gamepad_button(gp_padl, "left",  1);
input_default_gamepad_button(gp_padr, "right", 1);
input_default_gamepad_button(gp_padu, "up",    1);
input_default_gamepad_button(gp_padd, "down",  1);

input_default_gamepad_button(gp_face1, "confirm");
input_default_gamepad_button(gp_face2, "cancel" );

//input_player_source_set(INPUT_SOURCE.KEYBOARD_AND_MOUSE, 0);
//input_player_source_set(INPUT_SOURCE.GAMEPAD, 1);
//input_player_source_set(INPUT_SOURCE.GAMEPAD, 2);
//
//input_player_gamepad_set(0, 1);
//input_player_gamepad_set(1, 2);

assigning = true;
success   = false;