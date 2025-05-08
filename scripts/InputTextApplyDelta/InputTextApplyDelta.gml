function InputTextApplyDelta(_string)
{
    static _system = __InputTextSystem();
    return string_copy(_string, 1, max(0, string_length(_string) - _system.__removeCount)) + _system.__textDelta;
}