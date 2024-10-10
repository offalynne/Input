// Feather disable all

function __InputStringMatches()
{
    var _i = 1;
    repeat(argument_count - 1)
    {
        if (string(argument[_i]) == argument[0]) return true;
        ++_i;
    }
    
    return false;
}