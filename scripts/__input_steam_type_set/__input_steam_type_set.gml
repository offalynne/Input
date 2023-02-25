/// @param steamType
/// @param simpleType
/// @param description

function __input_steam_type_set(_steam_type, _simple_type, _description)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    _global.__steam_type_to_raw[$  string(_steam_type)] = _simple_type;   
    _global.__steam_type_to_name[$ string(_steam_type)] = _description; 
}