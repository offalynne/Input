function __input_load_sdl2_from_string_internal(_string)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    var _t = get_timer();
    
    if (!__INPUT_SILENT) __input_trace("Unpacking SDL2 string...");
    
    //Split by newlines
    var _lines = string_split(_string, "\n", true);
    
    //Variables for statistics and fast access
    var _total_count          = 0;
    var _platform_count       = 0;
    var _db_by_guid           = _global.__sdl2_database.by_guid;
    var _db_by_vendor_product = _global.__sdl2_database.by_vendor_product;
    var _db_by_description    = _global.__sdl2_database.by_description;
    
    //Parse all lines
    var _i = 0;
    repeat(array_length(_lines))
    {
        //Trim line, in case of removing extra whitespace (like Windows newline characters)
        var _line = string_trim(_lines[_i]);
        ++_i;
        
        //Skip empty lines and comments
        if (string_length(_line) == 0) continue;
        if (string_byte_at(_line, 0) == ord("#")) continue;
        
        //Read row. Note that this removes empty entries.
        ++_total_count;
        var _row_array = string_split(_line, ",", true);
        
        //Identify this definition's vendor+product and description names
        var _guid = _row_array[0];
        var _result = __input_gamepad_guid_parse(_guid, false, true);
        var _vendor_product = _result.vendor + _result.product;
        var _description    = _result.description;
                
        //Find what platform this definition is for by searching through the row's values
        //We do this backwards for the sake of efficiency since platform is usually tacked on the end
        var _platform = undefined;
        var _x = array_length(_row_array)-1;
        repeat(array_length(_row_array))
        {
            var _lower = string_lower(_row_array[_x]);
            if (_lower == "platform:windows" ) { _platform = os_windows; break; }
            if (_lower == "platform:mac"     ) { _platform = os_macosx;  break; }
            if (_lower == "platform:macos"   ) { _platform = os_macosx;  break; }
            if (_lower == "platform:macosx"  ) { _platform = os_macosx;  break; }
            if (_lower == "platform:mac os"  ) { _platform = os_macosx;  break; }
            if (_lower == "platform:mac os x") { _platform = os_macosx;  break; }
            if (_lower == "platform:linux"   ) { _platform = os_linux;   break; }
            if (_lower == "platform:android" ) { _platform = os_android; break; }
            if (_lower == "platform:ios"     ) { _platform = os_ios;     break; }
            --_x;
        }
                
        //If we didn't find a platform for the definition then show a warning message for it
        if (_platform == undefined) __input_trace("Warning! Platform not found for ", _row_array);
                
        //We ignore any definition that has a platform that's different to our current platform
        if ((_platform == undefined) || (_platform == os_type))
        {
            ++_platform_count;
                    
            if (_description != "")
            {
                //Add this definition to the GUID-description struct
                var _description_array = _db_by_description[$ _description];
                if (is_array(_description_array))
                {
                    //Push the definition into the GUID-description array
                    _description_array[@ array_length(_description_array)] = _row_array;
                }
                else
                {
                    //Create new GUID-description array, with this definition
                    _db_by_description[$ _description] = [_row_array];
                }
            }                    
            else if (_vendor_product != "")
            {
                //Add this definition to the "by vendor+product" struct
                var _vp_array = _db_by_vendor_product[$ _vendor_product];
                if (is_array(_vp_array))
                {
                    //Push the definition into the vendor+product array
                    _vp_array[@ array_length(_vp_array)] = _row_array;
                }
                else
                {
                    //Create new vendor+product array, with this definition
                    _db_by_vendor_product[$ _vendor_product] = [_row_array];
                }
            }
                    
            if (variable_struct_exists(_db_by_guid, _guid))
            {
                //We have a GUID collision then it's probably the user overwriting
                __input_trace("Warning! Overwriting GUID \"", _guid, "\" with ", _row_array, " (old=", _db_by_guid[$ _guid], ")");
            }
                    
            //Add this definition by GUID to our by-GUID database
            _db_by_guid[$ _guid] = _row_array;
        }
    }
    
    if (!__INPUT_SILENT) 
    {
        __input_trace(_total_count, " controller definitions found, of which ", _platform_count, " are active for this platform");
        __input_trace("Loaded in ", (get_timer() - _t)/1000, "ms");
    }
    
    return true;
}