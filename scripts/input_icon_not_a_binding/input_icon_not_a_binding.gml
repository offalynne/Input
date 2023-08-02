// Feather disable all
/// @param   icon

function input_icon_not_a_binding(_icon)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    var _name = "not a binding";
    
    var _icon_holder = _global.__icons[$ _name];
    if (!is_struct(_icon_holder))
    {
        _icon_holder = new __input_class_icon_category(_name);
        _global.__icons[$ string(_name)] = _icon_holder;
    }
    
    _icon_holder.add(all, _icon);
    
    return _icon_holder;
}
