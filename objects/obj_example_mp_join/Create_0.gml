if (INPUT_MULTIPLAYER_ABORT_CALLBACK == undefined)
{
    __input_error("INPUT_MULTIPLAYER_ABORT_CALLBACK must be defined for this example\n(Set it to a blank function i.e. (function(){})  )");
}

//Start the JOIN source mode
//This automatically assigns sources to players as they join the game by pressing something on a gamepad/keyboard/mouse
input_source_mode_set(INPUT_SOURCE_MODE.JOIN);
input_multiplayer_params_set(2, 2);
