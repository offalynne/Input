// Feather disable all

function InputTextApplyDelta(_string)
{
   static _system = __InputTextSystem();
   with(_system)
    {
        __enabled = true;
        return string_copy(_string, 1, max(0, string_length(_string) - __removeCount)) + __textDelta;
    }
    
    return _string;
}