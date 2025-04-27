// We store the callback array separately as the System initialization flow

function __InputSystemCallbackArray()
{
    static _array = array_create_ext(INPUT_PLUG_IN_CALLBACK.__SIZE, function()
    {
        return [];
    });
    
    return _array;
}