var _high = 60000;
var _low  = -32;

input_default_key(_high   , "invalid high key");
input_default_key(_low    , "invalid low key" );
input_default_key(vk_tab  , "tab key"         );
input_default_key(ord("A"), "A key"           );

input_default_mouse_button(_high    , "invalid high mouse"  );
input_default_mouse_button(_low     , "invalid low mouse"   );
input_default_mouse_button(mb_left  , "mouse button left"   );
input_default_mouse_button(mb_right , "mouse button right"  );
input_default_mouse_button(mb_middle, "mouse button middle" );
input_default_mouse_button(mb_side1 , "mouse button back"   );
input_default_mouse_button(mb_side2 , "mouse button forward");

input_default_mouse_wheel_down("mouse wheel down");
input_default_mouse_wheel_up("mouse wheel up");

input_default_gamepad_button(_high         , "invalid high gamepad button");
input_default_gamepad_button(_low          , "invalid low gamepad button" );
input_default_gamepad_button(gp_face1      , "gamepad button south"       );
input_default_gamepad_button(gp_shoulderlb , "gamepad trigger left"       );
input_default_gamepad_button(gp_padu       , "gamepad dpad up"            );

input_default_gamepad_axis(_high    , true,  "invalid high gamepad axis");
input_default_gamepad_axis(_low     , false, "invalid low gamepad axis" );
input_default_gamepad_axis(gp_axislh, true,  "gamepad thumbstick left"  );