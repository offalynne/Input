input_binding_set_default("up",     input_binding_key(vk_up    ));
input_binding_set_default("down",   input_binding_key(vk_down  ));
input_binding_set_default("left",   input_binding_key(vk_left  ));
input_binding_set_default("right",  input_binding_key(vk_right ));
input_binding_set_default("accept", input_binding_key(vk_space ));
input_binding_set_default("cancel", input_binding_key(vk_escape));

input_chord_define("up + down", INPUT_CHORD_DEFAULT_TIME, "up", "down");

input_combo_define("konami")
.press("up")
.press("up")
.press("down")
.press("down")
.press("left")
.press("right")
.press("left")
.press("right")
.press("cancel")
.press("accept");

input_combo_define("sweep right->up")
.press("right")
.press("up")
.press("accept");

input_combo_define("power attack right")
.hold("accept")
.press("right")
.press("right")
.release("accept", "right");

input_combo_define("fireball")
.press("accept")
.press("down")
.press("right")
.press_or_release("accept");
