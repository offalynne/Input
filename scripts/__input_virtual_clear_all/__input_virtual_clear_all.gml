function __input_virtual_clear_all()
{
    var _i = 0;
    repeat(array_length(global.__input_virtual_array))
    {
        global.__input_verb_group_array[_i].__clear_state();
        ++_i;
    }
}