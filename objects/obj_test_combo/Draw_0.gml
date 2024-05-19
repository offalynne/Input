var _string = concat(
"down = ", input_value("down"), "\n",
"left = ", input_value("left"), "\n",
"right = ", input_value("right"), "\n",
"accept = ", input_value("accept"), "\n",
"\n",
"\"hadouken\" = down -> down+right -> right -> accept\n",
"\"hadouken\" press = ", input_check_pressed("hadouken"), "\n",
"\"hadouken\" phase = ", input_combo_get_phase("hadouken"), " / ", input_combo_get_phase_count("hadouken"), "\n",
"\"hadouken\" new phase = ", input_combo_get_new_phase("hadouken"), "\n",
"\"hadouken\" direction = ", input_combo_get_direction("hadouken"), "\n",
"\n",
"\"charged attack\" = hold left -> right -> accept\n",
"\"charged attack\" press = ", input_check_pressed("charged attack"), "\n",
"\"charged attack\" phase = ", input_combo_get_phase("charged attack"), " / ", input_combo_get_phase_count("charged attack"), "\n",
"\"charged attack\" new phase = ", input_combo_get_new_phase("charged attack"), "\n",
"\"charged attack\" direction = ", input_combo_get_direction("charged attack"), "\n",
"\"charged attack\" charge = ", input_combo_get_charge("charged attack"), "\n",
);

draw_text(10, 10, _string);