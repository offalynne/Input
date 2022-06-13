//Keyboard input is for testing ONLY
//Do NOT do this in an actual game
//Use the "alternate input" functionality in the binding system instead for mirrored keyboard controls
if (input_keyboard_check(ord("A"))) input_verb_set("left",  1.0);
if (input_keyboard_check(ord("W"))) input_verb_set("up",    1.0);
if (input_keyboard_check(ord("S"))) input_verb_set("down",  1.0);
if (input_keyboard_check(ord("D"))) input_verb_set("right", 1.0);

if (input_keyboard_check(ord("J"))) input_verb_set("left",  0.0);
if (input_keyboard_check(ord("I"))) input_verb_set("up",    0.0);
if (input_keyboard_check(ord("K"))) input_verb_set("down",  0.0);
if (input_keyboard_check(ord("L"))) input_verb_set("right", 0.0);