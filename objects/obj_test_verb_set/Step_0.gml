//Keyboard input is for testing ONLY
//Do NOT do this in an actual game
//Use the "alternate input" functionality in the binding system instead for mirrored keyboard controls
if (keyboard_check_direct(ord("A"))) input_verb_set("left",  1.0);
if (keyboard_check_direct(ord("W"))) input_verb_set("up",    1.0);
if (keyboard_check_direct(ord("S"))) input_verb_set("down",  1.0);
if (keyboard_check_direct(ord("D"))) input_verb_set("right", 1.0);

if (keyboard_check_direct(ord("J"))) input_verb_set("left",  0.0);
if (keyboard_check_direct(ord("I"))) input_verb_set("up",    0.0);
if (keyboard_check_direct(ord("K"))) input_verb_set("down",  0.0);
if (keyboard_check_direct(ord("L"))) input_verb_set("right", 0.0);