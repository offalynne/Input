// Feather disable all

/// Returns the number of verbs defined in `InputDefineVerb()`.

function InputVerbCount()
{
    static _system = (function()
    {
        //Force initialization of player array as that also forces initialization of __InputConfigVerbs()
        __InputSystemPlayerArray();
        return __InputSystem();
    })();
    
    return _system.__verbCount;
}