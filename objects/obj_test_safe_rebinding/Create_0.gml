input_default_key(vk_left,  "left" );
input_default_key(vk_right, "right");
input_default_key(vk_up,    "up"   );
input_default_key(vk_down,  "down" );

input_default_key(ord("A"), "left",  1);
input_default_key(ord("D"), "right", 1);
input_default_key(ord("W"), "up",    1);
input_default_key(ord("S"), "down",  1);

input_default_gamepad_axis(gp_axislh, true,  "left" );
input_default_gamepad_axis(gp_axislh, false, "right");
input_default_gamepad_axis(gp_axislv, true,  "up"   );
input_default_gamepad_axis(gp_axislv, false, "down" );

rebinding      = false;
rebinding_verb = "up";
rebinding_alt  = 0;