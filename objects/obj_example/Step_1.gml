input_tick();
input_hotswap_tick();

if (input_check_p(VERB.PAUSE)) rebinding = true;
if (rebinding)
{
    if (input_rebind_tick(VERB.UP) != 0) rebinding = false;
}