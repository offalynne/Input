/// @param verbName
/// @param [verbName]...

function input_history_global_include()
{
    var _i = 0;
    repeat(argument_count)
    {
        global.__input_history_include[$ argument[_i]] = true;
        ++_i;
    }
}