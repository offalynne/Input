var _string = string_join("\n",
    string_concat("repeat (accept) = ", InputRepeat(INPUT_VERB.ACCEPT)),
    string_concat("duration (accept) = ", InputDuration(INPUT_VERB.ACCEPT)),
    string_concat("opposing (up/down) = ", InputOpposing(INPUT_VERB.UP, INPUT_VERB.DOWN)),
    string_concat("opposing pressed (up/down) = ", InputOpposingPressed(INPUT_VERB.UP, INPUT_VERB.DOWN)),
    string_concat("opposing repeat (up/down) = ", InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN)),
);

draw_text(10, 10, _string);