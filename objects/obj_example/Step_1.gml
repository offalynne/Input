input_tick();
input_hotswap_tick();

if (input_check_p(VERB.PAUSE)) rebinding = true;
if (rebinding)
{
    var _binding = input_binding_scan_tick();
    if (_binding != undefined)
    {
        input_binding_set_safe(VERB.UP, _binding);
        rebinding = false;
    }
}