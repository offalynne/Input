//Player 1 controls
var _string = "";
_string += "Player 1:\n";

if (input_source_using(INPUT_GAMEPAD, 0))
{
    _string += input_binding_get_icon(input_binding_get("left")) + "/" + input_binding_get_icon(input_binding_get("right")) + "/" + input_binding_get_icon(input_binding_get("up")) + "/" + input_binding_get_icon(input_binding_get("down")) + " = Move\n";
    _string += input_binding_get_icon(input_binding_get("aim_left")) + "/" + input_binding_get_icon(input_binding_get("aim_right")) + "/" + input_binding_get_icon(input_binding_get("aim_up")) + "/" + input_binding_get_icon(input_binding_get("aim_down")) + " = Aim\n";
    _string += input_binding_get_icon(input_binding_get("shoot", 0, 0)) + "/" + input_binding_get_icon(input_binding_get("shoot", 0, 1)) + " = Shoot\n";
    _string += input_binding_get_icon(input_binding_get("pause")) + " = Go Back\n";
}
else
{
    _string += input_binding_get_icon(input_binding_get("left", 0, 1)) + "/" + input_binding_get_icon(input_binding_get("right", 0, 1)) + "/" + input_binding_get_icon(input_binding_get("up", 0, 1)) + "/" + input_binding_get_icon(input_binding_get("down", 0, 1)) + " = Move\n";
    _string += "Mouse = Aim\n";
    _string += input_binding_get_icon(input_binding_get("shoot")) + " = Shoot\n";
    _string += input_binding_get_icon(input_binding_get("pause")) + " = Go Back\n";
}

draw_text(10, 10, _string);



//Player 2 controls
draw_set_halign(fa_right);
var _string = "";
_string += "Player 2:\n";

if (input_source_using(INPUT_GAMEPAD, 1))
{
    _string += input_binding_get_icon(input_binding_get("left", 1), 1) + "/" + input_binding_get_icon(input_binding_get("right", 1), 1) + "/" + input_binding_get_icon(input_binding_get("up", 1), 1) + "/" + input_binding_get_icon(input_binding_get("down", 1), 1) + " = Move\n";
    _string += input_binding_get_icon(input_binding_get("aim_left", 1), 1) + "/" + input_binding_get_icon(input_binding_get("aim_right", 1), 1) + "/" + input_binding_get_icon(input_binding_get("aim_up", 1), 1) + "/" + input_binding_get_icon(input_binding_get("aim_down", 1), 1) + " = Aim\n";
    _string += input_binding_get_icon(input_binding_get("shoot", 1, 0), 1) + "/" + input_binding_get_icon(input_binding_get("shoot", 1, 1), 1) + " = Shoot\n";
    _string += input_binding_get_icon(input_binding_get("pause", 1), 1) + " = Go Back\n";
}
else
{
    _string += input_binding_get_icon(input_binding_get("left", 1, 1), 1) + "/" + input_binding_get_icon(input_binding_get("right", 1, 1), 1) + "/" + input_binding_get_icon(input_binding_get("up", 1, 1), 1) + "/" + input_binding_get_icon(input_binding_get("down", 1, 1), 1) + " = Move\n";
    _string += "Mouse = Aim\n";
    _string += input_binding_get_icon(input_binding_get("shoot", 1), 1) + " = Shoot\n";
    _string += input_binding_get_icon(input_binding_get("pause", 1), 1) + " = Go Back\n";
}

draw_text(room_width-10, 10, _string);
draw_set_halign(fa_left);