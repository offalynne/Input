/// @desc    Destroys all virtual buttons

function input_virtual_destroy_all()
{
    var _i = 0;
    repeat(array_length(global.__input_virtual_array))
    {
        with(global.__input_verb_group_array[_i])
        {
            if (!__background) destroy();
        }
        
        ++_i;
    }
}