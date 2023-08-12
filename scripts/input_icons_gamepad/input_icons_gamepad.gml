// Feather disable all
/// @desc    Adds an icon category to Input, for use internally with input_binding_get_icon()
///          This function is part of a fluent interface e.g.
///              input_icons_gamepad(INPUT_GAMEPAD_TYPE_XBOX_ONE)
///              .add("gamepad face south", "A")
///              .add("gamepad face east",  "B")
///              .add("gamepad face west",  "X")
///              .add("gamepad face north", "Y")
///              //etc.
/// 
/// @param   categoryName

function input_icons_gamepad(_name)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_name == "not a binding") __input_error("Please use input_icon_not_a_binding() to define \"not a binding\" fallback icon");
    if (_name == "empty") __input_error("Please use input_icon_empty() to define empty binding fallback icon");
    if (_name == "keyboard") __input_error("Please use input_icons_keyboard() to define keyboard icons");
    
    var _icon_holder = _global.__icons[$ _name];
    if (!is_struct(_icon_holder))
    {
        _icon_holder = new __input_class_icon_category(_name);
        _global.__icons[$ string(_name)] = _icon_holder;
    }
    
    return _icon_holder;
}
