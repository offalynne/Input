var _string = "";
_string += "left  = " + string(input_value(TEST_ACTIONS.left )) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.left ))) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.left,  undefined, undefined, 1))) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.left,  undefined, undefined, 2))) + "\n";
_string += "right = " + string(input_value(TEST_ACTIONS.right)) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.right))) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.right, undefined, undefined, 1))) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.right, undefined, undefined, 2))) + "\n";
_string += "beam  = " + string(input_value(TEST_ACTIONS.beam )) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.beam ))) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.beam,  undefined, undefined, 1))) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.beam,  undefined, undefined, 2))) + "\n";

if (mode == 2)
{
    _string += "\n";
    _string += "p2left  = " + string(input_value(TEST_ACTIONS.p2left )) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.p2left ))) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.p2left,  undefined, undefined, 1))) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.p2left,  undefined, undefined, 2))) + "\n";
    _string += "p2right = " + string(input_value(TEST_ACTIONS.p2right)) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.p2right))) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.p2right, undefined, undefined, 1))) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.p2right, undefined, undefined, 2))) + "\n";
    _string += "p2beam  = " + string(input_value(TEST_ACTIONS.p2beam )) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.p2beam ))) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.p2beam,  undefined, undefined, 1))) + "    " + string(input_binding_get_name(input_binding_get(TEST_ACTIONS.p2beam,  undefined, undefined, 2))) + "\n";
}

draw_text(10, 10, _string);