/// @param stance
/// @param verb
/// @param [verb]...

function input_stance_define()
{
    var _stance = argument[0];
    
    var _i = 0;
    repeat(argument_count - 1)
    {
        var _verb = argument[_i];
        
        var _array = global.__input_verb_stances[$ _verb];
        if (is_array(_array))
        {
            array_push(_array, _stance);
        }
        else
        {
            _array = [_stance];
            global.__input_verb_stances[$ _verb] = _array;
        }
        
        ++_i;
    }
}