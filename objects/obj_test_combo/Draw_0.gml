var _string = concat(
"down = ", input_value("down"), "\n",
"left = ", input_value("left"), "\n",
"right = ", input_value("right"), "\n",
"accept = ", input_value("accept"), "\n",
"\n",
"hadouken press = ", input_check_pressed("hadouken"), "\n",
"hadouken check = ", input_check("hadouken"), "\n",
"hadouken release = ", input_check_released("hadouken"), "\n",
"hadouken value = ", input_value("hadouken"), "\n",
"\n",
"hadouken phase = ", input_combo_get_phase("hadouken"), " / ", input_combo_get_phase_count("hadouken"), "\n",
"hadouken direction = ", input_combo_get_direction("hadouken"), " (directional=", (input_combo_get_directional("hadouken")? "true" : "false"), ")\n",
"hadouken charge = ", input_combo_get_charge("hadouken"), "\n",
);

draw_text(10, 10, _string);