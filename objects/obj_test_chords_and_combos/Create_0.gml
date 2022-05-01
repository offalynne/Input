input_verb_build("up",     input_binding_key(vk_up    ));
input_verb_build("down",   input_binding_key(vk_down  ));
input_verb_build("left",   input_binding_key(vk_left  ));
input_verb_build("right",  input_binding_key(vk_right ));
input_verb_build("accept", input_binding_key(vk_space ));
input_verb_build("cancel", input_binding_key(vk_escape));

input_chord_create("up + down", INPUT_CHORD_DEFAULT_TIME, "up", "down");

input_combo_create("konami")
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

input_combo_create("sweep right->up")
.press("right")
.press("up")
.press("accept");

input_combo_create("power attack right")
.hold("accept")
.press("right")
.press("right")
.release("accept", "right");

input_combo_create("fireball")
.press("accept")
.press("down")
.press("right")
.press_or_release("accept");

input_source_hotswap_tick();