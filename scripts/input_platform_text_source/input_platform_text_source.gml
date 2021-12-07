function input_platform_text_source()
{
    if (__INPUT_ON_CONSOLE || (__INPUT_ON_WEB && !__INPUT_ON_DESKTOP))
    {
        return "async";
    }
    else if (__INPUT_ON_MOBILE)
    {
        var _ret = "virtual";
        if (os_type == os_android)
        {
            var _map = os_get_info();
            if (ds_exists(_map, ds_type_map))
            {
                if (_map[? "PHYSICAL_KEYBOARD"])
                {
                    _ret = "keyboard";
                }
                
                ds_map_destroy(_map);
            }
        }

        return _ret;
    }
    else
    {
        return "keyboard";
    }
    
    __input_error("Failed to identify platform text source");
}
