input_default_key(vk_left,  VERB.LEFT );
input_default_key(vk_right, VERB.RIGHT);
input_default_key(vk_up,    VERB.UP   );
input_default_key(vk_down,  VERB.DOWN );

input_default_key(ord("A"), VERB.LEFT,  1);
input_default_key(ord("D"), VERB.RIGHT, 1);
input_default_key(ord("W"), VERB.UP,    1);
input_default_key(ord("S"), VERB.DOWN,  1);

input_default_gamepad_axis(gp_axislh, true,  VERB.LEFT );
input_default_gamepad_axis(gp_axislh, false, VERB.RIGHT);
input_default_gamepad_axis(gp_axislv, true,  VERB.UP   );
input_default_gamepad_axis(gp_axislv, false, VERB.DOWN );

rebinding      = false;
rebinding_verb = VERB.UP;
rebinding_alt  = 0;