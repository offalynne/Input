/// @param categoryName

function input_icons(_name)
{
    __input_initialize();
    
    var _icon_holder = global.__input_icons[$ _name];
    if (!is_struct(_icon_holder))
    {
        _icon_holder = new __input_class_icon_category(_name);
        global.__input_icons[$ _name] = _icon_holder;
    }
    
    return _icon_holder;
}