/// This function should be called in the scope of a gamepad class

function __input_gamepad_find_in_sdl2_database()
{
    if (!__INPUT_SDL2_SUPPORT || !INPUT_SDL2_REMAPPING || blacklisted || xinput) return;

    var _guid = guid;
    var _description_based = false;
    
    //Clean up description-based GUID for SDL2 database lookup
    if ((string_copy(_guid, 13, 4) != "0000") && (string_copy(_guid, 0, 8) == "05000000"))
    {       
        var _i = 0;
        var _description_list = ["47532047616d65706164", "48494420446576696365", "4e696d6275732b", "47532067616d65706164", "6964726f69643a636f6e", "434f4d4d414e44"];
        repeat(array_length(_description_list))
        {
            if (string_pos(string(_description_list[_i]), _guid) > 0)
            {
                //Reconstruct GUID and pad right
                _guid = "05000000" + _description_list[_i];
                _guid += string_repeat("0", 32 - string_length(_guid));
                __input_trace("Evaluating GUID ", guid, " as ", _guid);
                break;
            }
            
            ++_i;
        }
        
        _description_based = true;
    }
  
    //Check to see if our device GUID matches the SDL2 database perfectly somewhere
    var _guid_dict = global.__input_sdl2_database.by_guid;
    if (variable_struct_exists(_guid_dict, _guid))
    {
        __input_trace("Gamepad database mapping found (GUID match)");
        var _definition = _guid_dict[$ _guid];
        sdl2_definition = _definition;
        description     = _definition[1];
        return;
    }
    
    var _definition = undefined;
    
    //Otherwise search through our vendor+product IDs
    var _vp_array = global.__input_sdl2_database.by_vendor_product[$ vendor + product];
    if (!_description_based && is_array(_vp_array))
    {
        if (array_length(_vp_array) > 0) //Get the first binding for this vendor+product and OS
        {
            _definition = _vp_array[0];
        }
    }
    
    if (is_array(_definition))
    {
        __input_trace("Gamepad database mapping found (vendor+product and OS match)");
        sdl2_definition = _definition;
        description     = _definition[1];
    }
    else
    {
        __input_trace("Warning! No SDL definition found for ", _guid, " (vendor=", vendor, ", product=", product, ")");
        sdl2_definition = undefined;
        description     = "Unknown";
    }
}
