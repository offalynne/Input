/// @desc    Adds an icon category to Input, for use internally with input_binding_get_icon()
///          This function is part of a fluent interface e.g.
///              input_icons(INPUT_GAMEPAD_TYPE_XBOX_ONE)
///              .add("gamepad face south", "A")
///              .add("gamepad face east",  "B")
///              .add("gamepad face west",  "X")
///              .add("gamepad face north", "Y")
///              //etc.
/// 
/// @param   categoryName

function input_icons(_name)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    var _icon_holder = _global.__icons[$ _name];
    if (!is_struct(_icon_holder))
    {
        _icon_holder = new __input_class_icon_category(_name);
        _global.__icons[$ string(_name)] = _icon_holder;
    }
    
    return _icon_holder;
}