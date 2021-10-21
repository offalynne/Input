input_tick();
input_hotswap_tick();

if (input_check_p("pause")) rebinding = true;
if (rebinding)
{
    var _binding = input_binding_scan_tick(input_player_source_get());
    if (_binding != undefined)
    {
        input_binding_set_safe("up", _binding);
        rebinding = false;
    }
}