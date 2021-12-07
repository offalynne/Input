input_tick();
input_source_hotswap_tick();

if (keyboard_check_pressed(vk_space)) rebinding = !rebinding;

if (rebinding)
{
    var _binding = input_binding_scan_tick(input_player_source_get());
    if (_binding != undefined)
    {
        input_binding_set_safe("test 1", _binding);
        rebinding = false;
    }
}