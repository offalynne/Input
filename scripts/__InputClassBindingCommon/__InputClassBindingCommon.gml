function __InputClassBindingCommon() constructor
{
    static __type   = undefined;
    static __source = undefined;
    
    __constant = undefined;
    __label    = "empty binding";
    
    static __SetLabel = function(_label)
    {
        if (_label == undefined)
        {
            __label = __input_binding_get_label(__type, __constant, false);
        }
        else
        {
            __label = _label;
        }
        
        return self;
    }
}