input_tick();

//Keyboard input is for testing ONLY
//Do NOT do this in an actual game
//Use the "alternate input" functionality in the binding system instead for mirrored keyboard controls
if (input_keyboard_check(ord("A"))) input_verb_set(VERB.LEFT,  1.0);
if (input_keyboard_check(ord("W"))) input_verb_set(VERB.UP,    1.0);
if (input_keyboard_check(ord("S"))) input_verb_set(VERB.DOWN,  1.0);
if (input_keyboard_check(ord("D"))) input_verb_set(VERB.RIGHT, 1.0);