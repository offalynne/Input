if (INPUT_MAX_ALTERNATE_BINDINGS != 3) __input_error("INPUT_MAX_ALTERNATE_BINDINGS must equal 3 for this test case");

enum TEST_ACTIONS
{
    left,
    right,
    beam,
    p2left,
    p2right,
    p2beam
}

mode = 1;

input_default_key(vk_left, TEST_ACTIONS.left);
input_default_key(ord("A"), TEST_ACTIONS.left, 1);
input_default_key(vk_right, TEST_ACTIONS.right);
input_default_key(ord("S"), TEST_ACTIONS.right, 1);
input_default_key(vk_down, TEST_ACTIONS.beam);
input_default_key(ord("Z"), TEST_ACTIONS.beam, 1);
input_default_key(vk_up, TEST_ACTIONS.beam, 2);