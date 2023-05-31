function __input_class_icon_category(_name) constructor
{
    __name       = _name;
    __dictionary = {};
    __swap_ab    = __input_gamepad_type_swap_ab(_name);
    
    static add = function(_binding_name, _icon)
    {
        if (__swap_ab)
        {
            static _a = __input_binding_get_label(__INPUT_BINDING_GAMEPAD_BUTTON, gp_face1, false);
            static _b = __input_binding_get_label(__INPUT_BINDING_GAMEPAD_BUTTON, gp_face2, false);
            if      (_binding_name == _a) { _binding_name = _b; }
            else if (_binding_name == _b) { _binding_name = _a; }
        }
        
        __dictionary[$ _binding_name] = _icon;
        return self;
    }
}
