/// @desc    Destroys all virtual buttons

function input_virtual_destroy_all()
{
    var _i = 0;
    repeat(array_length(_global.__virtual_array))
    {
        with(_global.__verb_group_array[_i])
        {
            if (!__background) destroy();
        }
        
        ++_i;
    }
}