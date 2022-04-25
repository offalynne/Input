rebinding = false;

input_default_key(vk_left,      "left"    );
input_default_key(vk_right,     "right"   );
input_default_key(vk_up,        "up"      );
input_default_key(vk_down,      "down"    );
input_default_key(vk_space,     "confirm" );
input_default_key(vk_backspace, "cancel"  );
input_default_key(vk_escape,    "pause"   );
input_default_key(vk_enter,     "pause", 1);

input_default_mouse_button(mb_left, "confirm", 1);
input_default_mouse_button(mb_side1, "cancel",  1);

input_binding_system_swap_gamepad_ab(false);
input_default_gamepad_axis(gp_axislh, true,  "left" );
input_default_gamepad_axis(gp_axislh, false, "right");
input_default_gamepad_axis(gp_axislv, true,  "up"   );
input_default_gamepad_axis(gp_axislv, false, "down" );
input_default_gamepad_button(gp_face1,  "confirm"   );
input_default_gamepad_button(gp_face2,  "cancel"    );
input_default_gamepad_button(gp_start,  "pause"     );
input_default_gamepad_button(gp_select, "pause",   1);
input_default_gamepad_button(gp_padl,   "left",    1);
input_default_gamepad_button(gp_padr,   "right",   1);
input_default_gamepad_button(gp_padu,   "up",      1);
input_default_gamepad_button(gp_padd,   "down",    1);