/// This function should be called in the scope of a gamepad class

function __input_gamepad_set_vid_pid()
{
    if (__INPUT_ON_HTML5)
    {
        var _vendor_pos  = string_pos("Vendor: ",  description);
        var _product_pos = string_pos("Product: ", description);
        
        if ((_vendor_pos > 0) && (_product_pos > 0))
        {
            //Chrome-esque form
            vendor  = string_copy(description, _vendor_pos  + 8, 4);
            product = string_copy(description, _product_pos + 9, 4);
            xinput  = undefined;
        }
        else if ((string_length(description) > 10) && (string_char_at(description, 5) == "-") && (string_char_at(description, 10) == "-"))
        {
            //Firefox-esque form
            vendor  = string_copy(description, 1, 4);
            product = string_copy(description, 6, 4);
            xinput  = undefined;
        }
        else
        {
            vendor  = "";
            product = "";
            xinput  = undefined;
            
            __input_trace("Gamepad description could not be parsed. Bindings for this gamepad may be incorrect (was \"", description, "\")");
        }
        
        //Unreverse the VID/PID hex strings
        if (is_string(vendor )) vendor  = string_copy(vendor,  3, 2) + string_copy(vendor,  1, 2);
        if (is_string(product)) product = string_copy(product, 3, 2) + string_copy(product, 1, 2);
    }
    else
    {
        //Unpack the vendor/product IDs from the gamepad's GUID
        if (os_type == os_windows)
        {
            var _result = __input_gamepad_guid_parse(guid, true, false); //Windows uses an older version of SDL
            vendor  = _result.vendor;
            product = _result.product;
            xinput  = (index < 4);
        }
        else if ((os_type == os_macosx) || (os_type == os_linux) || (os_type == os_ios) || (os_type == os_android))
        {
            var _result = __input_gamepad_guid_parse(guid, false, false);
            vendor  = _result.vendor;
            product = _result.product;
            xinput  = undefined;
        }
        else
        {
            vendor  = "";
            product = "";
            xinput  = undefined;
        }
    }
}