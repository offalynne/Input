input_tick();
input_hotswap_tick();

if (keyboard_check_pressed(ord("1")))
{
    mode = 1;
    
    input_default_key(vk_left, TEST_ACTIONS.left);
    input_default_key(ord("A"), TEST_ACTIONS.left, 1);
    input_default_key(vk_right, TEST_ACTIONS.right);
    input_default_key(ord("S"), TEST_ACTIONS.right, 1);
    input_default_key(vk_down, TEST_ACTIONS.beam);
    input_default_key(ord("Z"), TEST_ACTIONS.beam, 1);
    input_default_key(vk_up, TEST_ACTIONS.beam, 2);
}

if (keyboard_check_pressed(ord("2")))
{
    mode = 2;
    
    input_default_key(ord("A"), TEST_ACTIONS.left);
    input_default_key(ord("S"), TEST_ACTIONS.right);
    input_default_key(ord("Z"), TEST_ACTIONS.beam);
    input_default_key(vk_left, TEST_ACTIONS.p2left);
    input_default_key(vk_right, TEST_ACTIONS.p2right);
    input_default_key(vk_down, TEST_ACTIONS.p2beam);
    input_default_key(vk_up, TEST_ACTIONS.p2beam, 1);
    
    input_binding_remove(TEST_ACTIONS.beam, INPUT_SOURCE.KEYBOARD_AND_MOUSE, 0, 2);
}