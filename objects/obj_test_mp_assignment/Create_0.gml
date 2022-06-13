if (INPUT_MULTIPLAYER_LEAVE_VERB == undefined) __input_error("INPUT_MULTIPLAYER_LEAVE_VERB must be defined for this test case");
if (INPUT_MULTIPLAYER_ABORT_CALLBACK == undefined) __input_error("INPUT_MULTIPLAYER_ABORT_CALLBACK must be defined for this test case");

success = false;

input_source_mode_set(INPUT_SOURCE_MODE.JOIN);
input_multiplayer_params_set(2, 3);