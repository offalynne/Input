var _string = string_join("\n",
    string_concat("InputPressedMany([up, down]) = ", InputPressedMany([INPUT_VERB.UP, INPUT_VERB.DOWN])),
    string_concat("InputCheckMany([up, down]) = ", InputCheckMany([INPUT_VERB.UP, INPUT_VERB.DOWN])),
    string_concat("InputReleasedMany([up, down]) = ", InputReleasedMany([INPUT_VERB.UP, INPUT_VERB.DOWN])),
    string_concat("InputPressedMany(-1) = ", InputPressedMany(-1)),
    string_concat("InputCheckMany(-1) = ", InputCheckMany(-1)),
    string_concat("InputReleasedMany(-1) = ", InputReleasedMany(-1)),
);

draw_text(10, 10, _string);