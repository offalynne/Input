// Feather disable all
/// @desc    Destroys all virtual buttons

function input_virtual_destroy_all()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    var _i = 0;
    repeat(array_length(_global.__virtual_array))
    {
        with(_global.__virtual_array[_i])
        {
            if (!__background) destroy();
        }
        
        ++_i;
    }
}
