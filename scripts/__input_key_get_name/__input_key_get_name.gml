// Feather disable all
function __input_key_get_name(_key)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    //Fix uses of straight strings instead of ord("A")
    if (is_string(_key)) _key = ord(string_upper(_key));

    var _lookup_name = _global.__key_name_dict[$ _key];
    if (_lookup_name == undefined)
    {
        //Return UTF8 character
        return chr(_key);    
    }
    else
    {
        //Return from lookup
        return _lookup_name;
    }
}
