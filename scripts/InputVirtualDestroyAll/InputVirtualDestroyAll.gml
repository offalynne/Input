// Feather disable all

/// Destroys all virtual buttons.

function InputVirtualDestroyAll()
{
    static _virtualButtonArray = __InputSystem().__virtualButtonArray;
    
    var _i = 0;
    repeat(array_length(_virtualButtonArray))
    {
        with(_virtualButtonArray[_i])
        {
            Destroy();
        }
        
        ++_i;
    }
}
