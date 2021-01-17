input_player_source_set(INPUT_SOURCE.KEYBOARD_AND_MOUSE);

input_default_key(vk_left     , VERB.LEFT    );
input_default_key(vk_right    , VERB.RIGHT   );
input_default_key(vk_up       , VERB.UP      );
input_default_key(vk_down     , VERB.DOWN    );
input_default_key(vk_space    , VERB.CONFIRM );
input_default_key(vk_backspace, VERB.CANCEL  );
input_default_key(vk_escape   , VERB.PAUSE   );
input_default_key(vk_enter    , VERB.PAUSE, 1);

input_history_start();
input_history_global_include(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, VERB.CONFIRM, VERB.CANCEL, VERB.PAUSE);