function __input_class_icon_category(_name) constructor
{
    __name       = _name;
    __dictionary = {};
    
    static add = function(_binding_name, _icon)
    {
        __dictionary[$ _binding_name] = _icon;
        return self;
    }
}