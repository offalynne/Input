input_combo_params_set_side_on("right", "left", 0);

input_combo_create("hadouken")
.hold("down")
.press("right")
.release("down")
.press_or_release("accept");

input_combo_create("charged attack")
.press("down")
.charge("left")
.press("right")
.press("accept");