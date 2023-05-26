input_source_mode_set(INPUT_SOURCE_MODE.FIXED);

//Drop player sources
var _i = 0;
repeat(INPUT_MAX_PLAYERS)
{
    input_source_clear(_i);
    ++_i;
}
