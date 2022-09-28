if (INPUT_MULTIPLAYER_LEAVE_VERB == undefined) __input_error("INPUT_MULTIPLAYER_LEAVE_VERB must be defined for this test case");
if (INPUT_MULTIPLAYER_ABORT_CALLBACK == undefined) __input_error("INPUT_MULTIPLAYER_ABORT_CALLBACK must be defined for this test case");

input_source_mode_set(INPUT_SOURCE_MODE.JOIN);
input_multiplayer_params_set(2, INPUT_MAX_PLAYERS);

input_cursor_elastic_set(room_width/2, room_height/2, 0.5, all);
input_cursor_set(room_width/2, room_height/2, all);
input_cursor_limit_circle(room_width/2, room_height/2, 200, all);
input_cursor_speed_set(80, all);