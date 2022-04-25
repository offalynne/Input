input_default_key(vk_up,     "up"    );
input_default_key(vk_down,   "down"  );
input_default_key(vk_left,   "left"  );
input_default_key(vk_right,  "right" );
input_default_key(vk_space,  "accept");
input_default_key(vk_escape, "cancel");

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
.press("right")
.press("up")
.press("accept");

input_combo_define("power attack right")
.hold("accept")
.press("right")
.press("right")
.press("right")
.release("accept", "right");
