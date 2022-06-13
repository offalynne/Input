var _string = "";
_string += "Top Down Shooter Example\n";
_string += "\n";

if (input_source_using(INPUT_GAMEPAD))
{
    _string += input_binding_get_icon(input_binding_get("left")) + "/" + input_binding_get_icon(input_binding_get("right")) + "/" + input_binding_get_icon(input_binding_get("up")) + "/" + input_binding_get_icon(input_binding_get("down")) + " = Move\n";
    _string += input_binding_get_icon(input_binding_get("aim_left")) + "/" + input_binding_get_icon(input_binding_get("aim_right")) + "/" + input_binding_get_icon(input_binding_get("aim_up")) + "/" + input_binding_get_icon(input_binding_get("aim_down")) + " = Aim\n";
    _string += input_binding_get_icon(input_binding_get("shoot", 0, 0)) + "/" + input_binding_get_icon(input_binding_get("shoot", 0, 1)) + " = Shoot\n";
}
else
{
    _string += input_binding_get_icon(input_binding_get("left", 0, 1)) + "/" + input_binding_get_icon(input_binding_get("right", 0, 1)) + "/" + input_binding_get_icon(input_binding_get("up", 0, 1)) + "/" + input_binding_get_icon(input_binding_get("down", 0, 1)) + " = Move\n";
    _string += "Mouse = Aim\n";
    _string += input_binding_get_icon(input_binding_get("shoot")) + " = Shoot\n";
}

draw_text(10, 10, _string);