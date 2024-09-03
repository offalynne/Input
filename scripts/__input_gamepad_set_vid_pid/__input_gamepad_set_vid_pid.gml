// Feather disable all
/// This function should be called in the scope of a gamepad class

function __input_gamepad_set_vid_pid()
{    
    if (INPUT_ON_WEB)
    {
        __vendor  = "";
        __product = "";
        __xinput  = undefined;
        
        if (__INPUT_ON_OPERAGX)
        {
            //FIXME - As of 2021-10-01 (runtime 2.3.5.458), Opera GX GUIDs don't give us a VID/PID at all
        }
        else
        {
            //Try to read from Chrome's VID/PID syntax
            // e.g. Description Vendor: xxxx Product: yyyy
            //                          ^VID          ^PID
            var _vendor_pos  = string_pos("Vendor: ",  __description);
            var _product_pos = string_pos("Product: ", __description);
            if ((_vendor_pos > 0) && (_product_pos > 0))
            {
                //Chrome-esque form
                __vendor      = string_copy(__description, _vendor_pos  + 8, 4);
                __product     = string_copy(__description, _product_pos + 9, 4);
                __description = string_copy(__description, 1, _vendor_pos-1);
            }
            else
            {
                //Otherwise try to find out if this browser is using Firefox's syntax
                // e.g. xxxx-yyyy-Description
                //      ^VID ^PID
                var _firefoxy = false;
                
                var _hyphen_count = string_count("-", __description);
                if (_hyphen_count >= 2)
                {
                    var _work_string = __description;
                    
                    //Fish out the VID/PID strings
                    var _hyphen_pos = string_pos("-", _work_string);
                    var _vendor_slice = string_copy(_work_string, 1, _hyphen_pos-1);
                    _work_string = string_delete(_work_string, 1, _hyphen_pos);
                    
                    var _hyphen_pos = string_pos("-", _work_string);
                    var _product_slice = string_copy(_work_string, 1, _hyphen_pos-1);
                    _work_string = string_delete(_work_string, 1, _hyphen_pos);
                    
                    //Left pad with zeros
                    repeat(4 - string_length(_vendor_slice )) _vendor_slice  = "0" + _vendor_slice;
                    repeat(4 - string_length(_product_slice)) _product_slice = "0" + _product_slice;
                    
                    //Trim down to 4 characters
                    _vendor_slice  = string_copy(_vendor_slice,  1, 4);
                    _product_slice = string_copy(_product_slice, 1, 4);
                    
                    //Check if all 4 characters are part of a hex code
                    _firefoxy = true;
                    var _i = 1;
                    repeat(4)
                    {
                        var _ord = ord(string_char_at(_vendor_slice, _i));
                        if not (((_ord >= 0x30) && (_ord <= 0x39))  //0...9
                             || ((_ord >= 0x41) && (_ord <= 0x46))  //A...F
                             || ((_ord >= 0x61) && (_ord <= 0x66))) //a...f
                        {
                            _firefoxy = false;
                            break;
                        }
                        
                        ++_i;
                    }
                }
                
                if (_firefoxy)
                {
                    //Firefox-esque form
                    __vendor      = _vendor_slice;
                    __product     = _product_slice;
                    __description = _work_string;
                }
                else if (!__INPUT_SILENT) 
                {
                    __input_trace("Gamepad __description could not be parsed. Bindings for this gamepad may be incorrect (was \"", __description, "\")");
                }
            }
            
            //Switch VID/PID hex string endianness
            if (is_string(__vendor )) __vendor  = string_copy(__vendor,  3, 2) + string_copy(__vendor,  1, 2);
            if (is_string(__product)) __product = string_copy(__product, 3, 2) + string_copy(__product, 1, 2);   
        }
    }
    else if (__INPUT_SDL2_SUPPORT)
    {
        //Unpack the __vendor/__product IDs from the gamepad's GUIDc
        if (__INPUT_ON_WINDOWS)
        {
            var _legacy = __input_string_contains(__guid, "000000000000504944564944"); //"PIDVID"
            var _result = __input_gamepad_guid_parse(__guid, _legacy, false);
            __vendor  = _result.vendor;
            __product = _result.product;
            __xinput  = (__index < 4) && (gamepad_get_description(__index) == "XInput STANDARD GAMEPAD");
        }
        else if (__INPUT_ON_MACOS || __INPUT_ON_LINUX || __INPUT_ON_ANDROID)
        {
            var _result = __input_gamepad_guid_parse(__guid, false, false);
            __vendor  = _result.vendor;
            __product = _result.product;
            __xinput  = undefined;
        }
        else
        {
            if (!__INPUT_SILENT) __input_trace("Warning! OS type check fell through unexpectedly (os_type = ", os_type, ")");
            __description = gamepad_get_description(__index);
            __vendor  = "";
            __product = "";
            __xinput  = undefined;
        }
    }
    else
    {
        //Some unsupported platform
        __description = gamepad_get_description(__index);
        __vendor  = "";
        __product = "";
        __xinput  = undefined;
    }
}
