//Feather disable all

//Player 1 controls
var _string = "";
_string += "Player 1:\n";

if (input_source_using(INPUT_GAMEPAD, 0))
{
    _string += input_verb_get_icon("left") + "/" + input_verb_get_icon("right") + "/" + input_verb_get_icon("up") + "/" + input_verb_get_icon("down") + " = Move\n";
    _string += input_verb_get_icon("aim_left") + "/" + input_verb_get_icon("aim_right") + "/" + input_verb_get_icon("aim_up") + "/" + input_verb_get_icon("aim_down") + " = Aim\n";
    _string += input_verb_get_icon("shoot", 0, 0) + "/" + input_verb_get_icon("shoot", 0, 1) + " = Shoot\n";
    _string += input_verb_get_icon("pause") + " = Go Back\n";
}
else
{
    _string += input_verb_get_icon("left", 0, 1) + "/" + input_verb_get_icon("right", 0, 1) + "/" + input_verb_get_icon("up", 0, 1) + "/" + input_verb_get_icon("down", 0, 1) + " = Move\n";
    _string += "Mouse = Aim\n";
    _string += input_verb_get_icon("shoot") + " = Shoot\n";
    _string += input_verb_get_icon("pause") + " = Go Back\n";
}

draw_text(10, 10, _string);



//Player 2 controls
draw_set_halign(fa_right);
var _string = "";
_string += "Player 2:\n";

if (input_source_using(INPUT_GAMEPAD, 1))
{
    _string += input_verb_get_icon("left", 1) + "/" + input_verb_get_icon("right", 1) + "/" + input_verb_get_icon("up", 1) + "/" + input_verb_get_icon("down", 1) + " = Move\n";
    _string += input_verb_get_icon("aim_left", 1) + "/" + input_verb_get_icon("aim_right", 1) + "/" + input_verb_get_icon("aim_up", 1) + "/" + input_verb_get_icon("aim_down", 1) + " = Aim\n";
    _string += input_verb_get_icon("shoot", 1, 0) + "/" + input_verb_get_icon("shoot", 1, 1) + " = Shoot\n";
    _string += input_verb_get_icon("pause", 1) + " = Go Back\n";
}
else
{
    _string += input_verb_get_icon("left", 1, 1) + "/" + input_verb_get_icon("right", 1, 1) + "/" + input_verb_get_icon("up", 1, 1) + "/" + input_verb_get_icon("down", 1, 1) + " = Move\n";
    _string += "Mouse = Aim\n";
    _string += input_verb_get_icon("shoot", 1) + " = Shoot\n";
    _string += input_verb_get_icon("pause", 1) + " = Go Back\n";
}

draw_text(room_width-10, 10, _string);
draw_set_halign(fa_left);