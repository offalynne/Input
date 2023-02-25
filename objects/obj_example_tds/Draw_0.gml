var _string = "";
_string += "Top Down Shooter Example\n";
_string += "\n";

if (input_source_using(INPUT_GAMEPAD))
{
    _string += input_verb_get_icon("left") + "/" + input_verb_get_icon("right") + "/" + input_verb_get_icon("up") + "/" + input_verb_get_icon("down") + " = Move\n";
    _string += input_verb_get_icon("aim_left") + "/" + input_verb_get_icon("aim_right") + "/" + input_verb_get_icon("aim_up") + "/" + input_verb_get_icon("aim_down") + " = Aim\n";
    _string += input_verb_get_icon("shoot", 0, 0) + "/" + input_verb_get_icon("shoot", 0, 1) + " = Shoot\n";
}
else
{
    _string += input_verb_get_icon("left", 0, 1) + "/" + input_verb_get_icon("right", 0, 1) + "/" + input_verb_get_icon("up", 0, 1) + "/" + input_verb_get_icon("down", 0, 1) + " = Move\n";
    _string += "Mouse = Aim\n";
    _string += input_verb_get_icon("shoot") + " = Shoot\n";
}

draw_text(10, 10, _string);