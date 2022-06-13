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

last_combo = "No combo";