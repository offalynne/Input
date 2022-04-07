/// This function should be called in the scope of a gamepad class

function __input_gamepad_set_mapping()
{
    #region Console
    
    //Switch requires some extra setup
    if (os_type == os_switch)
    {
        //Disallow dpad input from single Joy-Cons. This happens when moving the thumbstick around in horizontal mode
        if ((raw_type != "SwitchJoyConLeft") && (raw_type != "SwitchJoyConRight"))
        {
            set_mapping(gp_padu, gp_padu, __INPUT_MAPPING.BUTTON, "dpup");
            set_mapping(gp_padd, gp_padd, __INPUT_MAPPING.BUTTON, "dpdown");
            set_mapping(gp_padl, gp_padl, __INPUT_MAPPING.BUTTON, "dpleft");
            set_mapping(gp_padr, gp_padr, __INPUT_MAPPING.BUTTON, "dpright");
        }
        
        if ((raw_type == "SwitchJoyConLeft") || (raw_type == "SwitchJoyConRight"))
        {
            if (INPUT_SWITCH_HORIZONTAL_HOLDTYPE)
            {
                //Single Joy-Cons in horizontal report L/R/ZL/ZR as shoulder buttons even though they rest in the player's palm. No idea why, but we disallow that
                set_mapping(gp_shoulderl, 6, __INPUT_MAPPING.BUTTON, "leftshoulder");
                set_mapping(gp_shoulderr, 7, __INPUT_MAPPING.BUTTON, "rightshoulder");
            }
            else
            {
                //SL/SR are still technically active in vertical mode too but that's silly so we ignore them
                set_mapping(gp_shoulderl,  8, __INPUT_MAPPING.BUTTON, "leftshoulder");
                set_mapping(gp_shoulderlb, 9, __INPUT_MAPPING.BUTTON, "lefttrigger");
            }
        }
        else
        {
            //Even in other gamepad modes Switch triggers are digital rather than analogue so we treat those as strict buttons
            set_mapping(gp_shoulderl,  6, __INPUT_MAPPING.BUTTON, "leftshoulder");
            set_mapping(gp_shoulderr,  7, __INPUT_MAPPING.BUTTON, "rightshoulder");
            set_mapping(gp_shoulderlb, 8, __INPUT_MAPPING.BUTTON, "lefttrigger");
            set_mapping(gp_shoulderrb, 9, __INPUT_MAPPING.BUTTON, "righttrigger");
        }
        
        set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
        set_mapping(gp_face2, 0, __INPUT_MAPPING.BUTTON, "b");
        set_mapping(gp_face3, 3, __INPUT_MAPPING.BUTTON, "x");
        set_mapping(gp_face4, 2, __INPUT_MAPPING.BUTTON, "y");
                                  
        set_mapping(gp_start, 10, __INPUT_MAPPING.BUTTON, "start");
        
        //No select button exists for single Joy-Cons so ignore this entirely
        if ((raw_type != "SwitchJoyConLeft") && (raw_type != "SwitchJoyConRight"))
        {
            set_mapping(gp_select, 11, __INPUT_MAPPING.BUTTON, "back");
        }
        
        set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS,   "leftx");
        set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS,   "lefty");
        set_mapping(gp_stickl, 4, __INPUT_MAPPING.BUTTON, "leftstick");
        set_mapping(gp_axisrh, 2, __INPUT_MAPPING.AXIS,   "rightx");
        set_mapping(gp_axisrv, 3, __INPUT_MAPPING.AXIS,   "righty");
        set_mapping(gp_stickr, 5, __INPUT_MAPPING.BUTTON, "rightstick");
        
        exit;
    }
    
    //If we're on PlayStation or Xbox, don't remap anything special
    if (__INPUT_ON_PS || __INPUT_ON_XDK)
    {
        set_mapping(gp_padu,   gp_padu,   __INPUT_MAPPING.BUTTON, "dpup");
        set_mapping(gp_padd,   gp_padd,   __INPUT_MAPPING.BUTTON, "dpdown");
        set_mapping(gp_padl,   gp_padl,   __INPUT_MAPPING.BUTTON, "dpleft");
        set_mapping(gp_padr,   gp_padr,   __INPUT_MAPPING.BUTTON, "dpright");
        set_mapping(gp_start,  gp_start,  __INPUT_MAPPING.BUTTON, "start");
        set_mapping(gp_select, gp_select, __INPUT_MAPPING.BUTTON, "back");
        
        set_mapping(gp_shoulderl,  gp_shoulderl,  __INPUT_MAPPING.BUTTON, "leftshoulder");
        set_mapping(gp_shoulderr,  gp_shoulderr,  __INPUT_MAPPING.BUTTON, "rightshoulder");
        set_mapping(gp_shoulderlb, gp_shoulderlb, __INPUT_MAPPING.AXIS,   "lefttrigger");
        set_mapping(gp_shoulderrb, gp_shoulderrb, __INPUT_MAPPING.AXIS,   "righttrigger");
        
        set_mapping(gp_face1, gp_face1, __INPUT_MAPPING.BUTTON, "a");
        set_mapping(gp_face2, gp_face2, __INPUT_MAPPING.BUTTON, "b");
        set_mapping(gp_face3, gp_face3, __INPUT_MAPPING.BUTTON, "x");
        set_mapping(gp_face4, gp_face4, __INPUT_MAPPING.BUTTON, "y");
        
        set_mapping(gp_axislh, gp_axislh, __INPUT_MAPPING.AXIS,   "leftx");
        set_mapping(gp_axislv, gp_axislv, __INPUT_MAPPING.AXIS,   "lefty");
        set_mapping(gp_stickl, gp_stickl, __INPUT_MAPPING.BUTTON, "leftstick");
        set_mapping(gp_axisrh, gp_axisrh, __INPUT_MAPPING.AXIS,   "rightx");
        set_mapping(gp_axisrv, gp_axisrv, __INPUT_MAPPING.AXIS,   "righty");
        set_mapping(gp_stickr, gp_stickr, __INPUT_MAPPING.BUTTON, "rightstick");
        
        exit;
    }
    
    #endregion
    
    #region Blacklist
    
    if (blacklisted)
    {
        //Apply a blank mapping
        var _a = variable_struct_get_names(global.__input_sdl2_look_up_table);
        var _i = 0;
        repeat(array_length(_a))
        {
            set_mapping(global.__input_sdl2_look_up_table[$ _a[_i]], 0, undefined, _a[_i]);
            _i++;
        }

        exit;
    }
    
    #endregion
    
    #region Web
    
    if (__INPUT_ON_OPERAGX)
    {
        set_mapping(gp_face1,  0, __INPUT_MAPPING.BUTTON, "a");
        set_mapping(gp_face2,  1, __INPUT_MAPPING.BUTTON, "b");
        set_mapping(gp_face3, 12, __INPUT_MAPPING.BUTTON, "x");
        set_mapping(gp_face4, 13, __INPUT_MAPPING.BUTTON, "y");
        
        set_mapping(gp_shoulderl,   6, __INPUT_MAPPING.BUTTON, "leftshoulder");
        set_mapping(gp_shoulderr,   9, __INPUT_MAPPING.BUTTON, "rightshoulder");
        set_mapping(gp_shoulderlb, 14, __INPUT_MAPPING.BUTTON, "lefttrigger");
        set_mapping(gp_shoulderrb, 15, __INPUT_MAPPING.BUTTON, "righttrigger");
        
        set_mapping(gp_select, 11, __INPUT_MAPPING.BUTTON, "back");
        set_mapping(gp_start,   8, __INPUT_MAPPING.BUTTON, "start");
        set_mapping(gp_stickl,  7, __INPUT_MAPPING.BUTTON, "leftstick");
        set_mapping(gp_stickr, 10, __INPUT_MAPPING.BUTTON, "rightstick");
        
        set_mapping(gp_padu, 5, __INPUT_MAPPING.BUTTON, "dpup");
        set_mapping(gp_padd, 2, __INPUT_MAPPING.BUTTON, "dpdown");
        set_mapping(gp_padl, 3, __INPUT_MAPPING.BUTTON, "dpleft");
        set_mapping(gp_padr, 4, __INPUT_MAPPING.BUTTON, "dpright");
        
        set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx");
        set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty");
        set_mapping(gp_axisrh, 2, __INPUT_MAPPING.AXIS, "rightx");
        set_mapping(gp_axisrv, 3, __INPUT_MAPPING.AXIS, "righty");
        
        exit;
    }
    
    if (__INPUT_ON_WEB)
    {
        set_mapping(gp_face1, 0, __INPUT_MAPPING.BUTTON, "a");
        set_mapping(gp_face2, 1, __INPUT_MAPPING.BUTTON, "b");
        set_mapping(gp_face3, 2, __INPUT_MAPPING.BUTTON, "x");
        set_mapping(gp_face4, 3, __INPUT_MAPPING.BUTTON, "y");
        
        set_mapping(gp_shoulderl,  4, __INPUT_MAPPING.BUTTON, "leftshoulder");
        set_mapping(gp_shoulderr,  5, __INPUT_MAPPING.BUTTON, "rightshoulder");
        set_mapping(gp_shoulderlb, 6, __INPUT_MAPPING.BUTTON, "lefttrigger");
        set_mapping(gp_shoulderrb, 7, __INPUT_MAPPING.BUTTON, "righttrigger");
        
        set_mapping(gp_select,  8, __INPUT_MAPPING.BUTTON, "back");
        set_mapping(gp_start,   9, __INPUT_MAPPING.BUTTON, "start");
        set_mapping(gp_stickl, 10, __INPUT_MAPPING.BUTTON, "leftstick");
        set_mapping(gp_stickr, 11, __INPUT_MAPPING.BUTTON, "rightstick");
        
        if ((os_type == os_linux) && (os_browser == browser_firefox))
        {
            //ಠ_ಠ
            set_mapping(gp_padr, 6, __INPUT_MAPPING.AXIS, "dpright").clamp_positive = true;
            set_mapping(gp_padd, 7, __INPUT_MAPPING.AXIS, "dpdown" ).clamp_positive = true;
            
            var _mapping;
            _mapping = set_mapping(gp_padl, 6, __INPUT_MAPPING.AXIS, "dpleft");
            _mapping.clamp_negative = true;
            _mapping.reverse = true;
            
            _mapping = set_mapping(gp_padu, 7, __INPUT_MAPPING.AXIS, "dpup");
            _mapping.clamp_negative = true;
            _mapping.reverse = true;
        }
        else
        {
            set_mapping(gp_padu, 12, __INPUT_MAPPING.BUTTON, "dpup");
            set_mapping(gp_padd, 13, __INPUT_MAPPING.BUTTON, "dpdown");
            set_mapping(gp_padl, 14, __INPUT_MAPPING.BUTTON, "dpleft");
            set_mapping(gp_padr, 15, __INPUT_MAPPING.BUTTON, "dpright");
        }
        
        set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx");
        set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty");
        set_mapping(gp_axisrh, 2, __INPUT_MAPPING.AXIS, "rightx");
        set_mapping(gp_axisrv, 3, __INPUT_MAPPING.AXIS, "righty");
        
        if (INPUT_SDL2_ALLOW_EXTENDED)
        {
            set_mapping(gp_guide, 16, __INPUT_MAPPING.BUTTON, "guide");
            
            if ((simple_type == "ps4")  || (simple_type == "ps5"))
            {
                set_mapping(gp_touchpad, 17, __INPUT_MAPPING.BUTTON, "touchpad");   
            }
            else
            {
                set_mapping(gp_misc1, 17, __INPUT_MAPPING.BUTTON, "misc1");
            }
        }
        
        exit;
    }
    
    #endregion
    
    #region PC/UWP & Mobile
    
    if ((os_type == os_uwp) || ((os_type == os_windows) && xinput))
    {
        //Default XInput mapping for Windows. This mapping is super common!
        set_mapping(gp_padu,   0, __INPUT_MAPPING.BUTTON, "dpup");
        set_mapping(gp_padd,   1, __INPUT_MAPPING.BUTTON, "dpdown");
        set_mapping(gp_padl,   2, __INPUT_MAPPING.BUTTON, "dpleft");
        set_mapping(gp_padr,   3, __INPUT_MAPPING.BUTTON, "dpright");
        set_mapping(gp_start,  4, __INPUT_MAPPING.BUTTON, "start");
        set_mapping(gp_select, 5, __INPUT_MAPPING.BUTTON, "back");
            
        set_mapping(gp_stickl,    6, __INPUT_MAPPING.BUTTON, "leftstick");
        set_mapping(gp_stickr,    7, __INPUT_MAPPING.BUTTON, "rightstick");
        set_mapping(gp_shoulderl, 8, __INPUT_MAPPING.BUTTON, "leftshoulder");
        set_mapping(gp_shoulderr, 9, __INPUT_MAPPING.BUTTON, "rightshoulder");
            
        set_mapping(gp_face1, 12, __INPUT_MAPPING.BUTTON, "a");
        set_mapping(gp_face2, 13, __INPUT_MAPPING.BUTTON, "b");
        set_mapping(gp_face3, 14, __INPUT_MAPPING.BUTTON, "x");
        set_mapping(gp_face4, 15, __INPUT_MAPPING.BUTTON, "y");
            
        set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx");
        set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty").reverse = true;
        set_mapping(gp_axisrh, 2, __INPUT_MAPPING.AXIS, "rightx");
        set_mapping(gp_axisrv, 3, __INPUT_MAPPING.AXIS, "righty").reverse = true;
            
        //This bit is weird but it enables analogue input from triggers so...
        set_mapping(gp_shoulderlb, 4106, __INPUT_MAPPING.AXIS, "lefttrigger");
        set_mapping(gp_shoulderrb, 4107, __INPUT_MAPPING.AXIS, "righttrigger");
        
        exit;
    }
    
    #endregion
    
    #region Windows Xbox One Wireless BT (New firmware)

    if ((os_type == os_windows) && (vendor == "5e04")                  //Windows (DirectInput) Microsoft's VID
    && ((product == "e002") || (product == "fd02"))                    //XbOne Wireless Rev. 1 or 2 PID for BT
    && (gamepad_button_count(index ) == 17)                            //Probably new firmware based on button
    && (gamepad_axis_value(index, 1) == gamepad_axis_value(index, 2))  //On new firmware axes 1 and 2 are same
    && (gamepad_axis_value(index, 4) == gamepad_axis_value(index, 5))) //On new firmware axes 4 and 5 are same
    {
        __input_trace("Setting Xbox One Wireless controller to alternate mapping. Trigger data unavailable.");
        
        set_mapping(gp_face1, 0, __INPUT_MAPPING.BUTTON, "a");
        set_mapping(gp_face2, 1, __INPUT_MAPPING.BUTTON, "b");
        set_mapping(gp_face3, 3, __INPUT_MAPPING.BUTTON, "x");
        set_mapping(gp_face4, 4, __INPUT_MAPPING.BUTTON, "y");
    
        set_mapping(gp_shoulderl, 6, __INPUT_MAPPING.BUTTON, "leftshoulder");
        set_mapping(gp_shoulderr, 7, __INPUT_MAPPING.BUTTON, "rightshoulder");
    
        set_mapping(gp_select, 15, __INPUT_MAPPING.BUTTON, "back");
        set_mapping(gp_start,  11, __INPUT_MAPPING.BUTTON, "start");
    
        set_mapping(gp_stickl, 13, __INPUT_MAPPING.BUTTON, "leftstick");
        set_mapping(gp_stickr, 14, __INPUT_MAPPING.BUTTON, "rightstick");
    
        set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx");
        set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty");
        set_mapping(gp_axisrh, 3, __INPUT_MAPPING.AXIS, "rightx");
        set_mapping(gp_axisrv, 4, __INPUT_MAPPING.AXIS, "righty");
        
        set_mapping(gp_padu, 0, __INPUT_MAPPING.HAT, "dpup"   ).hat_mask = 1;
        set_mapping(gp_padr, 0, __INPUT_MAPPING.HAT, "dpright").hat_mask = 2;
        set_mapping(gp_padd, 0, __INPUT_MAPPING.HAT, "dpdown" ).hat_mask = 4;
        set_mapping(gp_padl, 0, __INPUT_MAPPING.HAT, "dpleft" ).hat_mask = 8;
    
        //No trigger data :-(
        set_mapping(gp_shoulderlb, 0, undefined, "lefttrigger");
        set_mapping(gp_shoulderrb, 0, undefined, "righttrigger");
    
        if (INPUT_SDL2_ALLOW_EXTENDED){ set_mapping(gp_guide, 16, __INPUT_MAPPING.BUTTON, "guide"); }
        
        exit;
    }
    
    #endregion
    
    #region MFi controller on Windows

    if ((raw_type == "AppleController") && (guessed_type == false) && (os_type == os_windows))
    {
        //MFi controllers have unreliable VID+PID, type is set on other indicators
        __input_trace("Setting MFi controller mapping");
        
        set_mapping(gp_padl, 0, __INPUT_MAPPING.BUTTON, "dpleft");
        set_mapping(gp_padd, 1, __INPUT_MAPPING.BUTTON, "dpdown");
        set_mapping(gp_padr, 2, __INPUT_MAPPING.BUTTON, "dpright");
        set_mapping(gp_padu, 3, __INPUT_MAPPING.BUTTON, "dpup");
        
        set_mapping(gp_face1, 4, __INPUT_MAPPING.BUTTON, "a");
        set_mapping(gp_face2, 5, __INPUT_MAPPING.BUTTON, "b");
        set_mapping(gp_face3, 6, __INPUT_MAPPING.BUTTON, "x");
        set_mapping(gp_face4, 7, __INPUT_MAPPING.BUTTON, "y");
    
        set_mapping(gp_shoulderl, 8, __INPUT_MAPPING.BUTTON, "leftshoulder");
        set_mapping(gp_shoulderr, 9, __INPUT_MAPPING.BUTTON, "rightshoulder");
    
        set_mapping(gp_stickr, 10, __INPUT_MAPPING.BUTTON, "rightstick");
        set_mapping(gp_stickl, 11, __INPUT_MAPPING.BUTTON, "leftstick");
        
        set_mapping(gp_select, 13, __INPUT_MAPPING.BUTTON, "back");
        set_mapping(gp_start,  14, __INPUT_MAPPING.BUTTON, "start");
    
        set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx");
        set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty").reverse = true;
        set_mapping(gp_axisrh, 2, __INPUT_MAPPING.AXIS, "rightx");
        set_mapping(gp_axisrv, 3, __INPUT_MAPPING.AXIS, "righty").reverse = true;
            
        //No trigger data :-(
        set_mapping(gp_shoulderlb, 0, undefined, "lefttrigger");
        set_mapping(gp_shoulderrb, 0, undefined, "righttrigger");
    
        if (INPUT_SDL2_ALLOW_EXTENDED) set_mapping(gp_guide, 12, __INPUT_MAPPING.BUTTON, "guide");
        
        exit;
    }
    
    #endregion
    
    #region Ouya Controller on MacOS
    
    if ((raw_type == "CommunityOuya") && (os_type == os_macosx))
    {
        //Ouya controller doesn't work at all in SDL on Mac, but buttons do in GM
        __input_trace("Setting Ouya controller mapping");
        
        set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
        set_mapping(gp_face2, 6, __INPUT_MAPPING.BUTTON, "b");
        set_mapping(gp_face3, 3, __INPUT_MAPPING.BUTTON, "x");
        set_mapping(gp_face4, 5, __INPUT_MAPPING.BUTTON, "y");
    
        set_mapping(gp_shoulderl, 7, __INPUT_MAPPING.BUTTON, "leftshoulder");
        set_mapping(gp_shoulderr, 8, __INPUT_MAPPING.BUTTON, "rightshoulder");                    
                    
        set_mapping(gp_shoulderlb, 15, __INPUT_MAPPING.BUTTON, "lefttrigger");
        set_mapping(gp_shoulderrb, 16, __INPUT_MAPPING.BUTTON, "righttrigger");
    
        set_mapping(gp_stickl,  9, __INPUT_MAPPING.BUTTON, "leftstick");
        set_mapping(gp_stickr, 10, __INPUT_MAPPING.BUTTON, "rightstick");

        set_mapping(gp_padu, 11, __INPUT_MAPPING.BUTTON, "dpup"   );
        set_mapping(gp_padr, 14, __INPUT_MAPPING.BUTTON, "dpright");
        set_mapping(gp_padd, 12, __INPUT_MAPPING.BUTTON, "dpdown" );
        set_mapping(gp_padl, 13, __INPUT_MAPPING.BUTTON, "dpleft" );
                    
        if (INPUT_SDL2_ALLOW_EXTENDED){ set_mapping(gp_guide, 18, __INPUT_MAPPING.BUTTON, "guide"); }
    
        set_mapping(gp_select, 0, undefined, "back"  );
        set_mapping(gp_start,  0, undefined, "start" );    
        set_mapping(gp_axislh, 0, undefined, "leftx" );
        set_mapping(gp_axislv, 0, undefined, "lefty" );
        set_mapping(gp_axisrh, 0, undefined, "rightx");
        set_mapping(gp_axisrv, 0, undefined, "righty");
            
        exit;
    }
    
    #endregion
    
    #region NeoGeo Mini on Windows and Linux

    if ((raw_type == "CommunityNeoGeoMini") && (guessed_type == false)
    && ((os_type == os_windows) || (os_type == os_linux)))
    {
        __input_trace("Overriding mapping to NeoGeo Mini");

        set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
        set_mapping(gp_face2, 0, __INPUT_MAPPING.BUTTON, "b");
        set_mapping(gp_face3, 2, __INPUT_MAPPING.BUTTON, "x");
        set_mapping(gp_face4, 3, __INPUT_MAPPING.BUTTON, "y");

        set_mapping(gp_select, 8, __INPUT_MAPPING.BUTTON, "back");
        set_mapping(gp_start,  9, __INPUT_MAPPING.BUTTON, "start");

        set_mapping(gp_padu, 0, __INPUT_MAPPING.HAT, "dpup"   ).hat_mask = 1;
        set_mapping(gp_padr, 0, __INPUT_MAPPING.HAT, "dpright").hat_mask = 2;
        set_mapping(gp_padd, 0, __INPUT_MAPPING.HAT, "dpdown" ).hat_mask = 4;
        set_mapping(gp_padl, 0, __INPUT_MAPPING.HAT, "dpleft" ).hat_mask = 8;

        exit;
    }

    #endregion    
    
    #region Nintendo Switch Online Controllers on Linux

    if ((vendor == "7e05") && (product == "1720") && (os_type == os_linux)
    && (raw_type == "CommunitySaturn") && (guessed_type == false))
    {
        if (string_count("Genesis 3btn", description))
        {
            __input_trace("Overriding mapping to Mega Drive 3b");
            
            set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
            set_mapping(gp_face2, 0, __INPUT_MAPPING.BUTTON, "b");
            
            set_mapping(gp_shoulderrb, 5, __INPUT_MAPPING.BUTTON, "righttrigger"); // C button
            
            set_mapping(gp_select, 7, __INPUT_MAPPING.BUTTON, "back");
            set_mapping(gp_start,  9, __INPUT_MAPPING.BUTTON, "start");
            
            set_mapping(gp_padu, 0, __INPUT_MAPPING.HAT, "dpup"   ).hat_mask = 1;
            set_mapping(gp_padr, 0, __INPUT_MAPPING.HAT, "dpright").hat_mask = 2;
            set_mapping(gp_padd, 0, __INPUT_MAPPING.HAT, "dpdown" ).hat_mask = 4;
            set_mapping(gp_padl, 0, __INPUT_MAPPING.HAT, "dpleft" ).hat_mask = 8;
            
            if (INPUT_SDL2_ALLOW_EXTENDED) { set_mapping(gp_guide, 12, __INPUT_MAPPING.BUTTON, "guide"); }
            
            exit;
        }
        else if (string_count("Genesis 6btn", description))
        {
            __input_trace("Overriding mapping to Mega Drive 6b");
            
            set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
            set_mapping(gp_face2, 0, __INPUT_MAPPING.BUTTON, "b");      
            set_mapping(gp_face3, 6, __INPUT_MAPPING.BUTTON, "x");
            set_mapping(gp_face4, 2, __INPUT_MAPPING.BUTTON, "y");
            
            set_mapping(gp_shoulderr,  4, __INPUT_MAPPING.BUTTON, "rightshoulder"); // Z button
            set_mapping(gp_shoulderrb, 5, __INPUT_MAPPING.BUTTON, "righttrigger");  // C button
            
            set_mapping(gp_select, 7, __INPUT_MAPPING.BUTTON, "back");
            set_mapping(gp_start,  9, __INPUT_MAPPING.BUTTON, "start");
            
            set_mapping(gp_padu, 0, __INPUT_MAPPING.HAT, "dpup"   ).hat_mask = 1;
            set_mapping(gp_padr, 0, __INPUT_MAPPING.HAT, "dpright").hat_mask = 2;
            set_mapping(gp_padd, 0, __INPUT_MAPPING.HAT, "dpdown" ).hat_mask = 4;
            set_mapping(gp_padl, 0, __INPUT_MAPPING.HAT, "dpleft" ).hat_mask = 8;
            
            if (INPUT_SDL2_ALLOW_EXTENDED) { set_mapping(gp_guide, 12, __INPUT_MAPPING.BUTTON, "guide"); }
            
            exit;
        }       
    }

    #endregion

    #region Remapping on SDL2 supported platforms
    
    if (__INPUT_SDL2_SUPPORT && INPUT_SDL2_REMAPPING)
    {
        if (is_array(sdl2_definition))
        {
            var _i = 2;
            repeat(array_length(sdl2_definition) - 3)
            {
                var _entry = sdl2_definition[_i];
                var _pos = string_pos(":", _entry);
            
                var _entry_name = string_copy(_entry, 1, _pos-1);
                var _entry_1 = string_delete(_entry, 1, _pos);
            
                //Search for leading -/+ in the entry name
                //This basically only ever gets used for Switch joycons
                var _output_negative = false;
                var _output_positive = false;
            
                if (string_char_at(_entry_name, 1) == "-")
                {
                    _output_negative = true;
                    _entry_name = string_delete(_entry_name, 1, 1);
                }
                else if (string_char_at(_entry_name, 1) == "+")
                {
                    _output_positive = true;
                    _entry_name = string_delete(_entry_name, 1, 1);
                }
            
                //Find the GameMaker-native constant for this entry name e.g. gp_face1, gp_axislh
                var _gm_constant = global.__input_sdl2_look_up_table[$ _entry_name];
                if (_gm_constant == undefined)
                {
                    __input_trace("Warning! Entry name \"", _entry_name, "\" not recognised (full string was \"", _entry, "\")");
                }
                else
                {
                    var _input_invert   = false;
                    var _input_negative = false;
                    var _input_positive = false;
                
                    if (string_char_at(_entry_1, string_length(_entry_1)) == "~")
                    {
                        _entry_1 = string_delete(_entry_1, string_length(_entry_1), 1);
                        _input_invert = true;
                    }
                
                    var _raw_type = undefined;
                    do
                    {
                        var _char = string_char_at(_entry_1, 1);
                        _entry_1 = string_delete(_entry_1, 1, 1);
                    
                        switch(_char)
                        {
                            case "~": _input_invert   = true; break;
                            case "-": _input_negative = true; break;
                            case "+": _input_positive = true; break;
                        
                            case "b":
                                //If we're in button mode but we have a sign for the output direction then this is a button-on-axis mapping
                                if (_output_negative || _output_positive)
                                {
                                    _raw_type = __INPUT_MAPPING.BUTTON_TO_AXIS;
                                }
                                else
                                {
                                    _raw_type = __INPUT_MAPPING.BUTTON;
                                }
                            break;
                            
                            case "a":
                                //If we're in axis mode but we have a sign for the output direction then this is a split axis mapping
                                if (_output_negative || _output_positive)
                                {
                                    _raw_type = __INPUT_MAPPING.SPLIT_AXIS;
                                }
                                else
                                {
                                    _raw_type = __INPUT_MAPPING.AXIS;
                                }
                            break;
                        
                            case "h":
                                //If we're in hat mode but we have a sign for the output direction then this is a hat-on-axis mapping
                                if (_output_negative || _output_positive)
                                {
                                    _raw_type = __INPUT_MAPPING.HAT_TO_AXIS;
                                }
                                else
                                {
                                    _raw_type = __INPUT_MAPPING.HAT;
                                }
                            break;
                        
                            default:
                                __input_trace("Warning! Mapping entry could not be parsed (full string was \"", _entry, "\")");
                            break;
                        }
                    }
                    until(_raw_type != undefined);
                
                    //Determine which input index to scan for
                    //We floor this to cope with hats have decimal parts for their mask
                    var _input_slot = floor(real(_entry_1));
                
                    //Try to find out if this constant has been set already
                    var _mapping = mapping_gm_to_raw[$ _gm_constant];
                    if (_raw_type == __INPUT_MAPPING.HAT_TO_AXIS)
                    {
                        if (_mapping == undefined)
                        {
                            _mapping = set_mapping(_gm_constant, undefined, _raw_type, _entry_name);
                        }
                    
                        if (_output_negative)
                        {
                            _mapping.raw_negative = _input_slot;
                        }
                        else if (_output_positive)
                        {
                            _mapping.raw_positive = _input_slot;
                        }
                    }
                    else if (_raw_type == __INPUT_MAPPING.SPLIT_AXIS)
                    {
                        if (_mapping == undefined)
                        {
                            _mapping = set_mapping(_gm_constant, undefined, _raw_type, _entry_name);
                        }
                    
                        if (_output_negative)
                        {
                            _mapping.raw_negative = _input_slot;
                            if (_input_negative) _mapping.negative_clamp_negative = true;
                            if (_input_positive) _mapping.negative_clamp_positive = true;
                        }
                        else if (_output_positive)
                        {
                            _mapping.raw_positive = _input_slot;
                            if (_input_negative) _mapping.positive_clamp_negative = true;
                            if (_input_positive) _mapping.positive_clamp_positive = true;
                        }
                    }
                    else if (_raw_type == __INPUT_MAPPING.BUTTON_TO_AXIS)
                    {
                        if (_mapping == undefined)
                        {
                            _mapping = set_mapping(_gm_constant, undefined, _raw_type, _entry_name);
                        }
                    
                        if (_output_negative)
                        {
                            _mapping.raw_negative = _input_slot;
                        }
                        else if (_output_positive)
                        {
                            _mapping.raw_positive = _input_slot;
                        }
                    }
                    else
                    {
                        if (_mapping == undefined)
                        {
                            _mapping = set_mapping(_gm_constant, _input_slot, _raw_type, _entry_name);
                        }
                        else
                        {
                            __input_trace("Warning! Mapping for \"", _entry, "\" is a redefinition of entry name \"", _entry_name, "\"");
                        }
                    
                        //If necessary, apply modifiers to the mapping input
                        if (_input_invert  ) _mapping.invert         = true;
                        if (_input_negative) _mapping.clamp_negative = true;
                        if (_input_positive) _mapping.clamp_positive = true;
                    }
                
                    //Now manage the hat masks, including setting up hat-on-axis masks
                    if ((_raw_type == __INPUT_MAPPING.HAT) || (_raw_type == __INPUT_MAPPING.HAT_TO_AXIS))
                    {
                        var _hat_mask = floor(10 * abs((real(_entry_1) mod 1)));
                        if (_raw_type == __INPUT_MAPPING.HAT)
                        {
                            _mapping.hat_mask = _hat_mask;
                        }
                        else if (_raw_type == __INPUT_MAPPING.HAT_TO_AXIS)
                        {
                            if (_output_negative)
                            {
                                _mapping.hat_mask_negative = _hat_mask;
                            }
                            else if (_output_positive)
                            {
                                _mapping.hat_mask_positive = _hat_mask;
                            }
                        }
                    }
                
                    if (__INPUT_DEBUG) __input_trace(_entry_name, " = ", _raw_type, _entry_1);
                
                    //Set axis range quirks
                    if ((_raw_type == __INPUT_MAPPING.AXIS) || (_raw_type == __INPUT_MAPPING.SPLIT_AXIS))
                    {
                        //Identify directional input
                        var _is_directional = __input_axis_is_directional(_gm_constant);
                
                        //Linux axis ranges affecting directional input are normalized after remapping
                        if ((os_type == os_linux) && _is_directional)
                        {    
                            if (__INPUT_DEBUG) __input_trace("  (Limited axis range)");
                            _mapping.limited_range = true;
                        }
                        else if ((os_type != os_linux) && !_is_directional && (gamepad_axis_count(index) >= _input_slot))
                        {
                            //Nondirectional axes (triggers) use full axis range (excepting Linux remappings and XInput)
                            if (__INPUT_DEBUG) __input_trace("  (Extended axis range)");
                            _mapping.extended_range = true;
                        }
                    }
                }
            
                ++_i;
            }
            
            //Reset Android keymapped dpad if necessary
            if ((os_type == os_android) && (gamepad_hat_count(index) != 0)
            && ((vendor == "") && (product == "")))
            {
                var _mapping = undefined;
                var _dpad_array = [gp_padu, gp_padd, gp_padl, gp_padr];
                
                var _matched = 0;
                repeat(array_length(_dpad_array))
                {
                    //Check mapping match (b11 - b14)
                    _mapping = mapping_gm_to_raw[$ _dpad_array[_matched]];
                    if (!is_struct(_mapping) || (_mapping[$ "raw"] != 11 + _matched)) break;
                    ++_matched;
                }
            
                if (_matched == 4)
                {
                    //Dpad mapping matches Android keymap, switch to hat
                    if (__INPUT_DEBUG) __input_trace("  (Remapping dpad buttons to hat)");                
                    set_mapping(gp_padu, 0, __INPUT_MAPPING.HAT, "dpup"   ).hat_mask = 1;
                    set_mapping(gp_padr, 0, __INPUT_MAPPING.HAT, "dpright").hat_mask = 2;
                    set_mapping(gp_padd, 0, __INPUT_MAPPING.HAT, "dpdown" ).hat_mask = 4;
                    set_mapping(gp_padl, 0, __INPUT_MAPPING.HAT, "dpleft" ).hat_mask = 8;
                }
            }
        }
        else
        {
            __input_trace("No SDL2 remapping available, falling back to GameMaker's mapping (", gamepad_get_mapping(index), ")");
        }
        
        if (INPUT_SDL2_ALLOW_EXTENDED)
        {
            //Add mapping for touchpad button click on PS4 gamepads on platforms supporting it.
            //Since the `touchpad` field is a later addition and largely missing from SDL2 data
            //we're manually mapping it in cases where an otherwise-normal PS4 mapping is found
            if (((os_type == os_windows) || (os_type == os_macosx)) && (simple_type == "ps4"))
            {
                var _matched = 0;
                var _mapping = undefined;
                var _button_array = [gp_face3, gp_face1, gp_face2, gp_face4];
                var _offset = ((mac_cleared_mapping && (os_type == os_macosx)) ? 17 : 0);

                repeat(array_length(_button_array))
                {
                    //Check mapping match (b0 - b3)
                    _mapping = mapping_gm_to_raw[$ _button_array[_matched]];
                    if (!is_struct(_mapping) || (_mapping[$ "raw"] != _matched + _offset)) break;
                    ++_matched;
                }

                if (_matched == 4)
                {
                    //Face button mapping matches normative PS4 gamepads, add `touchpad` button
                    if (__INPUT_DEBUG) __input_trace("  (Adding touchpad mapping)");
                    set_mapping(gp_touchpad, 13, __INPUT_MAPPING.BUTTON, "touchpad");
                }
            }
            
             //Change Ouya guide mapping
            if (((os_type == os_windows) || (os_type == os_linux)) && (raw_type == "CommunityOuya"))
            {
                //Guide button issues 2 reports: one a tick after release which is usually too fast for GM's
                //interupt to catch, and another that's for long press that works after being held 1 second.
                //SDL's map assigns the first but we switch to the second which will work reliably for GM.
                if (__INPUT_DEBUG) __input_trace("  (Remapping guide button)");
                set_mapping(gp_guide, 15, __INPUT_MAPPING.BUTTON, "guide");
            }
        }
    }
    
    #endregion
}
