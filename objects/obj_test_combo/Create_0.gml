input_combo_params_set_side_on("right", "left", 0);

input_combo_create("hadouken", 1000)
.press("down")
.press("right")
.release("down")
.press_or_release("accept");