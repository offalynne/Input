enum VERB
{
    LEFT,
    RIGHT,
    UP,
    DOWN,
    CONFIRM,
    CANCEL,
    PAUSE,
    X,
    Y
}

rebinding = false;

input_cursor_verbs(VERB.UP, VERB.DOWN, VERB.LEFT, VERB.RIGHT, 5);
input_cursor_move(room_width/2, room_height/2);

input_default_key(vk_left     , VERB.LEFT    );
input_default_key(vk_right    , VERB.RIGHT   );
input_default_key(vk_up       , VERB.UP      );
input_default_key(vk_down     , VERB.DOWN    );
input_default_key(vk_space    , VERB.CONFIRM );
input_default_key(vk_backspace, VERB.CANCEL  );
input_default_key(vk_escape   , VERB.PAUSE   );
input_default_key(vk_enter    , VERB.PAUSE, 1);

input_default_mouse_button(mb_left, VERB.CONFIRM, 1);

input_default_gamepad_swap_ab(false);
input_default_gamepad_axis(gp_axislh  , true , VERB.LEFT );
input_default_gamepad_axis(gp_axislh  , false, VERB.RIGHT);
input_default_gamepad_axis(gp_axislv  , true , VERB.UP   );
input_default_gamepad_axis(gp_axislv  , false, VERB.DOWN );
input_default_gamepad_button(gp_face1 , VERB.CONFIRM   );
input_default_gamepad_button(gp_face2 , VERB.CANCEL    );
input_default_gamepad_button(gp_start , VERB.PAUSE     );
input_default_gamepad_button(gp_select, VERB.PAUSE  , 1);
input_default_gamepad_button(gp_padl  , VERB.LEFT   , 1);
input_default_gamepad_button(gp_padr  , VERB.RIGHT  , 1);
input_default_gamepad_button(gp_padu  , VERB.UP     , 1);
input_default_gamepad_button(gp_padd  , VERB.DOWN   , 1);

input_history_start();
input_history_global_include(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, VERB.CONFIRM, VERB.CANCEL, VERB.PAUSE);