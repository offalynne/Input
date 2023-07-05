function __InputClassBindingCommon() constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE
    
    static __source     = undefined;
    static __sourceType = undefined;
    
    __constant = undefined;
    __label    = "empty binding";
    
    static __Set = function(_constant, _playerSet = false)
    {
        return self;
    }
    
    static __Read = function(_player, _verbState, hasKeyboard, _hasMouse, _hasGamepad, _mixedMode)
    {
    }
    
    static __Duplicate = function()
    {
        return new __InputClassBindingCommon();
    }
    
    static __Export = function()
    {
        return undefined;
    }
    
    static __Import = function(_struct)
    {
    }
    
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