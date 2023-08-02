// Feather disable all
function __input_string_contains()
{
    var _i = 1;
    
    repeat(argument_count - 1)
    {
        if (string_pos(string(argument[_i]), argument[0]) > 0)
        {
            return true;
        }
        
        ++_i;
    }
    
    return false;
}
