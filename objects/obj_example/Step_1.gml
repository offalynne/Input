if (input_check_pressed("pause")) rebinding = true;

if (rebinding)
{
    var _binding = input_binding_scan_tick();
    if (_binding != undefined)
    {
        input_binding_set_safe("up", _binding);
        rebinding = false;
    }
}