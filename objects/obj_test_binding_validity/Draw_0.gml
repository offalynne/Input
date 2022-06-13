var _high = 60000;
var _low  = -32;

var _string = "Source: " + string(input_source_get_array());

_string += "\n";
_string += "\n" + "Verb";

_string += "\n" + "invalid high key             " + string(input_binding_is_valid(input_binding_key(_high   )));
_string += "\n" + "invalid low key              " + string(input_binding_is_valid(input_binding_key(_low    )));
_string += "\n" + "tab key                      " + string(input_binding_is_valid(input_binding_key(vk_tab  )));
_string += "\n" + "A key                        " + string(input_binding_is_valid(input_binding_key(ord("A"))));

_string += "\n";

_string += "\n" + "invalid high mouse           " + string(input_binding_is_valid(input_binding_mouse_button(_high    )));
_string += "\n" + "invalid low mouse            " + string(input_binding_is_valid(input_binding_mouse_button(_low     )));
_string += "\n" + "mouse button left            " + string(input_binding_is_valid(input_binding_mouse_button(mb_left  )));
_string += "\n" + "mouse button right           " + string(input_binding_is_valid(input_binding_mouse_button(mb_right )));
_string += "\n" + "mouse button middle          " + string(input_binding_is_valid(input_binding_mouse_button(mb_middle)));
_string += "\n" + "mouse button back            " + string(input_binding_is_valid(input_binding_mouse_button(mb_side1 )));
_string += "\n" + "mouse button forward         " + string(input_binding_is_valid(input_binding_mouse_button(mb_side2 )));

_string += "\n";

_string += "\n" + "mouse wheel down             " + string(input_binding_is_valid(input_binding_mouse_wheel_down()));
_string += "\n" + "mouse wheel up               " + string(input_binding_is_valid(input_binding_mouse_wheel_up()));

_string += "\n";

_string += "\n" + "invalid high gamepad button  " + string(input_binding_is_valid(input_binding_gamepad_button(_high        )));
_string += "\n" + "invalid low gamepad button   " + string(input_binding_is_valid(input_binding_gamepad_button(_low         )));
_string += "\n" + "gamepad button south         " + string(input_binding_is_valid(input_binding_gamepad_button(gp_face1     )));
_string += "\n" + "gamepad trigger left         " + string(input_binding_is_valid(input_binding_gamepad_button(gp_shoulderlb)));
_string += "\n" + "gamepad dpad up              " + string(input_binding_is_valid(input_binding_gamepad_button(gp_padu      )));

_string += "\n";

_string += "\n" + "invalid high gamepad axis    " + string(input_binding_is_valid(input_binding_gamepad_axis(_high,     true )));
_string += "\n" + "invalid low gamepad axis     " + string(input_binding_is_valid(input_binding_gamepad_axis(_low,      false)));
_string += "\n" + "gamepad thumbstick left      " + string(input_binding_is_valid(input_binding_gamepad_axis(gp_axislh, true )));

draw_text(10, 10, _string);

