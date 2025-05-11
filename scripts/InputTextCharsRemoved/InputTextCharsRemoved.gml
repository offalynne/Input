function InputTextCharsRemoved()
{
    static _system = __InputTextSystem();
    _system.__enabled = true;
    return _system.__removeCount;
}