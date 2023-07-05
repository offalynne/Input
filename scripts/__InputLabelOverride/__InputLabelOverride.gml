/// @param key
/// @param name

function __InputLabelOverride(_key, _name)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    _global.__constantToLabelOverrideDict[$ string(_key)] = string(_name);
}