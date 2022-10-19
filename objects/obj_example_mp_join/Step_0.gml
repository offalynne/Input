//Allow either player to advance to gameplay
if (input_multiplayer_is_finished())
{
    if (input_check_long("action", 0))
    {
        input_source_mode_set(INPUT_SOURCE_MODE.FIXED);
        room_goto(rm_example_mp_gameplay);
    }
}