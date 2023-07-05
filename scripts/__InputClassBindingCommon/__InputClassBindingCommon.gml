function __InputClassBindingCommon() constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE
    
    static __type       = undefined;
    static __source     = undefined;
    static __sourceType = undefined;
    
    __constant = undefined;
    __label    = "empty binding";
    
    static toString = function()
    {
        return __label;
    }
    
    static __RefreshLabel = function(_label)
    {
        __label = __InputConstantToLabel(__constant);
        
        return self;
    }
    
    static __ForceLabel = function(_label)
    {
        __label = _label;
        
        return self;
    }
}