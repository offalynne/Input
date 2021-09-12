/// This function should be called in the scope of a gamepad class

function __input_gamepad_find_in_sdl2_database()
{
    if (!__INPUT_SDL2_SUPPORT || !INPUT_SDL2_REMAPPING || blacklisted || xinput) exit;
  
    //Check to see if our device GUID matches the SDL2 database perfectly somewhere
    var _guid_dict = global.__input_sdl2_database.by_guid;
    if (variable_struct_exists(_guid_dict, guid))
    {
        var _definition = _guid_dict[$ guid];
        sdl2_definition = _definition;
        description     = _definition[1];
        exit;
    }
    
    var _definition = undefined;
    
    //Otherwise search through our vendor+product IDs
    var _vp_array = global.__input_sdl2_database.by_vendor_product[$ vendor + product];
    if (is_array(_vp_array))
    {
        if (array_length(_vp_array) > 0) //Get the first binding for this vendor+product and OS
        {
            var _definition = _vp_array[0];
        }
    }
    
    if (is_array(_definition))
    {
        sdl2_definition = _definition;
        description     = _definition[1];
    }
    else
    {
        __input_trace("Warning! No SDL definition found for ", guid, " (vendor=", vendor, ", product=", product, ")");
        sdl2_definition = undefined;
        description     = "Unknown";
    }
}