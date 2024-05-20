// Feather disable all
/// This function should be called in the scope of a gamepad class

function __input_gamepad_find_in_sdl2_database()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!__INPUT_SDL2_SUPPORT || !INPUT_SDL2_REMAPPING || __blacklisted || __xinput) return;
  
    //Check to see if our device GUID matches the SDL2 database perfectly somewhere
    var _guid_dict = _global.__sdl2_database.by_guid;
    if (variable_struct_exists(_guid_dict, __guid))
    {
        var _definition = _guid_dict[$ __guid];
        __sdl2_definition = _definition;
        __description     = _definition[1];
        return;
    }
    
    var _definition = undefined;
    
    //Otherwise search through our GUID-based description IDs
    var _description_array = _global.__sdl2_database.by_description[$ string_copy(__guid, 1, 20)];
    if (is_array(_description_array))
    {
        if (array_length(_description_array) > 0) //Get the first binding for this description and OS
        {
            var _definition = _description_array[0];
        }
    }
    else
    {    
        //Otherwise search through our vendor+product IDs
        var _vp_array = _global.__sdl2_database.by_vendor_product[$ __vendor + __product];
        if (is_array(_vp_array))
        {
            if (array_length(_vp_array) > 0) //Get the first binding for this vendor+product and OS
            {
                var _definition = _vp_array[0];
            }
        }
    }
    
    if (is_array(_definition))
    {
        __sdl2_definition = _definition;
        __description     = _definition[1];
    }
    else
    {
        if (!__INPUT_SILENT) __input_trace("Warning! No SDL definition found for ", __guid, " (vendor=", __vendor, ", product=", __product, ")");
        __sdl2_definition = undefined;
    }
}
