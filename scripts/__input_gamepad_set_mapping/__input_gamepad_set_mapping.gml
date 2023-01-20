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
        
        return;
    }
    
    if (__INPUT_ON_PS || __INPUT_ON_XBOX)
    {
        set_mapping(gp_padu,   gp_padu,   __INPUT_MAPPING.BUTTON, "dpup");
        set_mapping(gp_padd,   gp_padd,   __INPUT_MAPPING.BUTTON, "dpdown");
        set_mapping(gp_padl,   gp_padl,   __INPUT_MAPPING.BUTTON, "dpleft");
        set_mapping(gp_padr,   gp_padr,   __INPUT_MAPPING.BUTTON, "dpright");
        set_mapping(gp_start,  gp_start,  __INPUT_MAPPING.BUTTON, "start");
        set_mapping(gp_select, gp_select, __INPUT_MAPPING.BUTTON, "back");
        
        set_mapping(gp_shoulderl,  gp_shoulderl,  __INPUT_MAPPING.BUTTON, "leftshoulder");
        set_mapping(gp_shoulderr,  gp_shoulderr,  __INPUT_MAPPING.BUTTON, "rightshoulder");
        
        set_mapping(gp_shoulderlb, (__INPUT_ON_PS? 4 : gp_shoulderlb), __INPUT_MAPPING.AXIS, "lefttrigger");
        set_mapping(gp_shoulderrb, (__INPUT_ON_PS? 5 : gp_shoulderrb), __INPUT_MAPPING.AXIS, "righttrigger");
        
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
        
        return;
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

        return;
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
        
        return;
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
        
        return;
    }
    
    #endregion
    
    #region XInput
    
    if (xinput)
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
        
        var _mapping_lt = set_mapping(gp_shoulderlb, __XINPUT_AXIS_LT, __INPUT_MAPPING.AXIS, "lefttrigger");
        var _mapping_rt = set_mapping(gp_shoulderrb, __XINPUT_AXIS_RT, __INPUT_MAPPING.AXIS, "righttrigger");
        
        if (is_numeric(__steam_handle))
        {
            //Typical XInput scale (0 to 255/256)
            _mapping_lt.scale = 255;
            _mapping_rt.scale = 255;
        }
        else
        {
            //Scale per Xbox One and Series controllers over USB (0 to 63/256)
            //Scale is recalibrated later if values fall outside of this range
            _mapping_lt.scale = 63;
            _mapping_rt.scale = 63;
            scale_trigger = true;
        }
        
        return;
    }
    
    #endregion
    
    #region Windows Xbox One Wireless BT (New firmware)

    if ((os_type == os_windows) && (vendor == "5e04")                  //Windows (DirectInput) Microsoft's VID
    && ((product == "e002") || (product == "fd02"))                    //XbOne Wireless Rev. 1 or 2 PID for BT
    && (button_count == 17)                                            //Probably new firmware based on button
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
    
        if (INPUT_SDL2_ALLOW_EXTENDED) set_mapping(gp_guide, 16, __INPUT_MAPPING.BUTTON, "guide");
        
        return;
    }
    
    #endregion
    
    #region Stadia Controller on Windows
    
    if ((raw_type == "CommunityStadia") && (os_type == os_windows))
    {
        //Analogue triggers and right stick mapping depends on Windows Registry setting
        __input_trace("Setting default Stadia controller mapping");
        
        set_mapping(gp_face1, 0, __INPUT_MAPPING.BUTTON, "a");
        set_mapping(gp_face2, 1, __INPUT_MAPPING.BUTTON, "b");
        set_mapping(gp_face3, 2, __INPUT_MAPPING.BUTTON, "x");
        set_mapping(gp_face4, 3, __INPUT_MAPPING.BUTTON, "y");
        
        set_mapping(gp_shoulderl, 4, __INPUT_MAPPING.BUTTON, "leftshoulder");
        set_mapping(gp_shoulderr, 5, __INPUT_MAPPING.BUTTON, "rightshoulder");
         
        set_mapping(gp_stickl, 6, __INPUT_MAPPING.BUTTON, "leftstick");
        set_mapping(gp_stickr, 7, __INPUT_MAPPING.BUTTON, "rightstick");
         
        set_mapping(gp_select, 8, __INPUT_MAPPING.BUTTON, "back");
        set_mapping(gp_start,  9, __INPUT_MAPPING.BUTTON, "start");
         
        if (INPUT_SDL2_ALLOW_EXTENDED)
        {
            set_mapping(gp_guide, 10, __INPUT_MAPPING.BUTTON, "guide"); //Stadia button
            //set_mapping(???,    13, __INPUT_MAPPING.BUTTON,  ???);    //Assistant button, no SDL key for this
            set_mapping(gp_misc1, 14, __INPUT_MAPPING.BUTTON, "misc1"); //Capture button
        }
        
        set_mapping(gp_padu, 0, __INPUT_MAPPING.HAT, "dpup"   ).hat_mask = 1;
        set_mapping(gp_padr, 0, __INPUT_MAPPING.HAT, "dpright").hat_mask = 2;
        set_mapping(gp_padd, 0, __INPUT_MAPPING.HAT, "dpdown" ).hat_mask = 4;
        set_mapping(gp_padl, 0, __INPUT_MAPPING.HAT, "dpleft" ).hat_mask = 8;
        
        set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx");
        set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty");
          
        //Set default mapping with digital triggers, test later
        test_trigger = true;
            
        set_mapping(gp_shoulderrb, 11, __INPUT_MAPPING.BUTTON, "righttrigger");
        set_mapping(gp_shoulderlb, 12, __INPUT_MAPPING.BUTTON, "lefttrigger");
        
        set_mapping(gp_axisrh, 3, __INPUT_MAPPING.AXIS, "rightx");
        set_mapping(gp_axisrv, 4, __INPUT_MAPPING.AXIS, "righty");
        
        return;
    }
    
    #endregion
    
    #region Unofficial Windows driver for official Wii U GCN USB
    
    if ((raw_type == "CommunityGameCube") && (vendor == "3412") && (product == "adbe") && (os_type == os_windows))
    {
        //Userland vJoy device feeder for WUP-028
        __input_trace("Setting GameCube adapter slot to alternate mapping");
        
        set_mapping(gp_face1, 0, __INPUT_MAPPING.BUTTON, "a");
        set_mapping(gp_face3, 1, __INPUT_MAPPING.BUTTON, "x");
        set_mapping(gp_face2, 2, __INPUT_MAPPING.BUTTON, "b");
        set_mapping(gp_face4, 3, __INPUT_MAPPING.BUTTON, "y");
        
        set_mapping(gp_shoulderr, 4, __INPUT_MAPPING.BUTTON, "rightshoulder");
        
        //if (INPUT_SDL2_ALLOW_EXTENDED) //Dual-stage trigger mapping (semantically incorrect)
        //{
        //    set_mapping(gp_paddle2, 5, __INPUT_MAPPING.BUTTON, "paddle2");
        //    set_mapping(gp_paddle1, 6, __INPUT_MAPPING.BUTTON, "paddle1");
        //}        
        
        set_mapping(gp_start, 7, __INPUT_MAPPING.BUTTON, "start");   
         
        set_mapping(gp_padu,  8, __INPUT_MAPPING.BUTTON, "dpup");
        set_mapping(gp_padd,  9, __INPUT_MAPPING.BUTTON, "dpdown");
        set_mapping(gp_padl, 10, __INPUT_MAPPING.BUTTON, "dpleft");
        set_mapping(gp_padr, 11, __INPUT_MAPPING.BUTTON, "dpright");  
        
        set_mapping(gp_shoulderlb, 2, __INPUT_MAPPING.AXIS, "lefttrigger" ).clamp_positive = true;
        set_mapping(gp_shoulderrb, 5, __INPUT_MAPPING.AXIS, "righttrigger").clamp_positive = true;           
        
        set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx");
        set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty");
        set_mapping(gp_axisrh, 3, __INPUT_MAPPING.AXIS, "rightx");
        set_mapping(gp_axisrv, 4, __INPUT_MAPPING.AXIS, "righty");
        
        return;
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
        
        return;
    }
    
    #endregion
    
    #region Missing mapping on MacOS
    
    if ((button_count == 22) && (axis_count ==  6) && (hat_count == 0) 
    && (gamepad_get_mapping(index) == "no mapping") && (os_type == os_macosx))
    {
        //Based on features this is a misconfigured Apple-supported gamepad
        __input_trace("Overriding from \"no mapping\" on Mac");
        
        set_mapping(gp_face1, 17, __INPUT_MAPPING.BUTTON, "a");
        set_mapping(gp_face2, 18, __INPUT_MAPPING.BUTTON, "b");
        set_mapping(gp_face3, 20, __INPUT_MAPPING.BUTTON, "x");
        set_mapping(gp_face4, 21, __INPUT_MAPPING.BUTTON, "y");
        
        set_mapping(gp_stickl, 4, __INPUT_MAPPING.BUTTON, "leftstick");
        set_mapping(gp_stickr, 5, __INPUT_MAPPING.BUTTON, "rightstick");
        
        set_mapping(gp_shoulderrb, 6, __INPUT_MAPPING.BUTTON, "righttrigger");
        set_mapping(gp_shoulderlb, 7, __INPUT_MAPPING.BUTTON, "lefttrigger");
        
        set_mapping(gp_select, 8, __INPUT_MAPPING.BUTTON, "back");
        set_mapping(gp_start, 10, __INPUT_MAPPING.BUTTON, "start");

        set_mapping(gp_shoulderl, 13, __INPUT_MAPPING.BUTTON, "leftshoulder");
        set_mapping(gp_shoulderr, 14, __INPUT_MAPPING.BUTTON, "rightshoulder");
        
        set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx");
        set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty");
        set_mapping(gp_axisrh, 2, __INPUT_MAPPING.AXIS, "rightx");
        set_mapping(gp_axisrv, 3, __INPUT_MAPPING.AXIS, "righty");        
        
        //No dpad data :-(
        
        if (INPUT_SDL2_ALLOW_EXTENDED)
        {
            set_mapping(gp_guide, 11, __INPUT_MAPPING.BUTTON, "guide");
            set_mapping(gp_misc1, 16, __INPUT_MAPPING.BUTTON, "misc1");
        }

        return;
    }
    
    #endregion
    
    #region Third party Joy-Cons on Windows and MacOS

    if ((vendor = "7e05") && (product = "0920")
    && (((os_type == os_windows) && (button_count == 16) && (axis_count ==  4) && (hat_count == 1))
     || ((os_type == os_macosx)  && (button_count == 24) && (axis_count == 10) && (hat_count == 1))))
    {
        //Based on features this is a Joy-Con spoofing the Pro Controller VID+PID
        __input_trace("Overriding mapping from Switch Pro to Joy-Con");
        
        //This is a bit weird as we cannot differentiate left Joy-Con from right
        //since we cannot see past the names provided by the internal mapping DB
        //Face buttons and shoulders correspond to the same value on both devices...
        set_mapping(gp_face1, 0, __INPUT_MAPPING.BUTTON, "a");
        set_mapping(gp_face2, 1, __INPUT_MAPPING.BUTTON, "b");
        set_mapping(gp_face3, 2, __INPUT_MAPPING.BUTTON, "x");
        set_mapping(gp_face4, 3, __INPUT_MAPPING.BUTTON, "y");

        set_mapping(gp_shoulderl, 4, __INPUT_MAPPING.BUTTON, "leftshoulder");
        set_mapping(gp_shoulderr, 5, __INPUT_MAPPING.BUTTON, "rightshoulder");

        //...however the remaining buttons are different on left and right Joy-Cons
        //As such we allow the type to remain "Switch" and map the leftover buttons
        //matching by their label. Imperfect, but good enough for these constraints
        set_mapping(gp_select,  8, __INPUT_MAPPING.BUTTON, "back");
        set_mapping(gp_start,   9, __INPUT_MAPPING.BUTTON, "start");
        set_mapping(gp_stickl, 10, __INPUT_MAPPING.BUTTON, "leftstick");
        set_mapping(gp_stickr, 11, __INPUT_MAPPING.BUTTON, "rightstick");

        if (INPUT_SDL2_ALLOW_EXTENDED)
        {
            set_mapping(gp_guide, 12, __INPUT_MAPPING.BUTTON, "guide");
            set_mapping(gp_misc1, 13, __INPUT_MAPPING.BUTTON, "misc1");
        }
        
        //Joy-Con horizontal solo grip hat-on-axis mapping
        var _mapping = set_mapping(gp_axislh, 0, __INPUT_MAPPING.HAT_TO_AXIS, "leftx");
        _mapping.raw_negative = 0;
        _mapping.raw_positive = 0;
        _mapping.hat_mask_negative = 8;
        _mapping.hat_mask_positive = 2;

        _mapping = set_mapping(gp_axislv, 0, __INPUT_MAPPING.HAT_TO_AXIS, "lefty")
        _mapping.raw_negative = 0;
        _mapping.raw_positive = 0;
        _mapping.hat_mask_negative = 1;
        _mapping.hat_mask_positive = 4;

        return;
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
                    
        if (INPUT_SDL2_ALLOW_EXTENDED) set_mapping(gp_guide, 18, __INPUT_MAPPING.BUTTON, "guide");
    
        set_mapping(gp_select, 0, undefined, "back"  );
        set_mapping(gp_start,  0, undefined, "start" );    
        set_mapping(gp_axislh, 0, undefined, "leftx" );
        set_mapping(gp_axislv, 0, undefined, "lefty" );
        set_mapping(gp_axisrh, 0, undefined, "rightx");
        set_mapping(gp_axisrv, 0, undefined, "righty");
            
        return;
    }
    
    #endregion
    
    #region Mayflash N64 Adapter on MacOS
    
    if ((vendor == "8f0e") && (product == "1330") && (raw_type == "CommunityN64") && (guessed_type = false) && (os_type == os_macosx))
    {
        __input_trace("Overriding mapping to N64");        
       
        set_mapping(gp_face1, 3, __INPUT_MAPPING.BUTTON, "a");
        set_mapping(gp_face2, 5, __INPUT_MAPPING.BUTTON, "b");

        set_mapping(gp_shoulderl,  13, __INPUT_MAPPING.BUTTON, "leftshoulder")
        set_mapping(gp_shoulderr,  15, __INPUT_MAPPING.BUTTON, "rightshoulder");;
        set_mapping(gp_shoulderlb, 17, __INPUT_MAPPING.BUTTON, "lefttrigger");
        set_mapping(gp_start,      19, __INPUT_MAPPING.BUTTON, "start");

        set_mapping(gp_padu, 25, __INPUT_MAPPING.BUTTON, "dpup"   );
        set_mapping(gp_padr, 27, __INPUT_MAPPING.BUTTON, "dpright");
        set_mapping(gp_padd, 29, __INPUT_MAPPING.BUTTON, "dpdown" );
        set_mapping(gp_padl, 31, __INPUT_MAPPING.BUTTON, "dpleft" );

        set_mapping(gp_axislh, 1, __INPUT_MAPPING.AXIS,  "leftx");
        set_mapping(gp_axislv, 3, __INPUT_MAPPING.AXIS,  "lefty");
        set_mapping(gp_axisrv, 5, __INPUT_MAPPING.AXIS, "righty");
        set_mapping(gp_axisrh, 7, __INPUT_MAPPING.AXIS, "rightx").reverse = true;
        
        set_mapping(gp_shoulderrb, 0, undefined, "righttrigger");
        set_mapping(gp_select,     0, undefined, "back");
        
        return;
    }
    
    #endregion
    
    #region NeoGeo Mini on Windows and Linux

    if ((raw_type == "CommunityNeoGeoMini") && (guessed_type == false) && ((os_type == os_windows) || (os_type == os_linux)))
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

        return;
    }

    #endregion 
    
    #region retro-bit Tribute 64 on Windows and Linux

    if ((vendor == "6325") && (product == "7505") && (raw_type == "CommunityN64") && (guessed_type == false) && ((os_type == os_windows) || (os_type == os_linux)))
    {
        __input_trace("Overriding mapping to N64");

        set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
        set_mapping(gp_face2, 2, __INPUT_MAPPING.BUTTON, "b");

        set_mapping(gp_start, 12, __INPUT_MAPPING.BUTTON, "start");

        set_mapping(gp_shoulderl,  4, __INPUT_MAPPING.BUTTON, "leftshoulder");
        set_mapping(gp_shoulderr,  5, __INPUT_MAPPING.BUTTON, "rightshoulder");
        set_mapping(gp_shoulderlb, 6, __INPUT_MAPPING.BUTTON, "lefttrigger");
        set_mapping(gp_shoulderrb, 7, __INPUT_MAPPING.BUTTON, "righttrigger");

        set_mapping(gp_padu, 0, __INPUT_MAPPING.HAT, "dpup"   ).hat_mask = 1;
        set_mapping(gp_padr, 0, __INPUT_MAPPING.HAT, "dpright").hat_mask = 2;
        set_mapping(gp_padd, 0, __INPUT_MAPPING.HAT, "dpdown" ).hat_mask = 4;
        set_mapping(gp_padl, 0, __INPUT_MAPPING.HAT, "dpleft" ).hat_mask = 8;

        set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx").limited_range = (os_type == os_linux);
        set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty").limited_range = (os_type == os_linux);

        var _mapping = set_mapping(gp_axisrh, undefined, __INPUT_MAPPING.BUTTON_TO_AXIS, "rightx");
        _mapping.raw_negative = 3;
        _mapping.raw_positive = 8;
        
        _mapping = set_mapping(gp_axisrv, undefined, __INPUT_MAPPING.BUTTON_TO_AXIS, "righty");
        _mapping.raw_negative = 9;
        _mapping.raw_positive = 0;

        return;
    }

    #endregion
    
    #region Nintendo Switch Online Controllers on Linux

    if ((vendor == "7e05") && (product == "1720") && (raw_type == "CommunitySaturn") && (guessed_type == false) && (os_type == os_linux))
    {
        if (__input_string_contains(description, "Genesis 3btn"))
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
            
            if (INPUT_SDL2_ALLOW_EXTENDED) set_mapping(gp_guide, 12, __INPUT_MAPPING.BUTTON, "guide");
            
            return;
        }
        else if (__input_string_contains(description, "Genesis 6btn"))
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
            
            if (INPUT_SDL2_ALLOW_EXTENDED) set_mapping(gp_guide, 12, __INPUT_MAPPING.BUTTON, "guide");
            
            return;
        }       
    }

    #endregion
    
    #region Non-normative HID mappings for Linux
    
    if (os_type == os_linux)
    {
        switch (raw_type)
        {            
            case "HIDJoyConLeft":
                __input_trace("Overriding mapping to Joy-Con Left");

                set_mapping(gp_face1,  9, __INPUT_MAPPING.BUTTON, "a");
                set_mapping(gp_face2,  8, __INPUT_MAPPING.BUTTON, "b");
                set_mapping(gp_face3,  7, __INPUT_MAPPING.BUTTON, "x");
                set_mapping(gp_face4, 10, __INPUT_MAPPING.BUTTON, "y");

                set_mapping(gp_shoulderl, 2, __INPUT_MAPPING.BUTTON, "leftshoulder");
                set_mapping(gp_shoulderr, 4, __INPUT_MAPPING.BUTTON, "rightshoulder");

                set_mapping(gp_select, 5, __INPUT_MAPPING.BUTTON, "back");
                set_mapping(gp_start,  0, __INPUT_MAPPING.BUTTON, "start");

                set_mapping(gp_stickl, 6, __INPUT_MAPPING.BUTTON, "leftstick");

                set_mapping(gp_axislh, 1, __INPUT_MAPPING.AXIS, "leftx").limited_range = true;

                var _mapping = set_mapping(gp_axislv, 0, __INPUT_MAPPING.AXIS, "lefty");
                _mapping.limited_range = true;
                _mapping.reverse       = true;
        
                return;
            break;
            
            case "HIDJoyConRight":
                __input_trace("Overriding mapping to Joy-Con Right");

                set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
                set_mapping(gp_face2, 2, __INPUT_MAPPING.BUTTON, "b");
                set_mapping(gp_face3, 0, __INPUT_MAPPING.BUTTON, "x");
                set_mapping(gp_face4, 3, __INPUT_MAPPING.BUTTON, "y");

                set_mapping(gp_select, 9, __INPUT_MAPPING.BUTTON, "back");
                set_mapping(gp_start,  8, __INPUT_MAPPING.BUTTON, "start");

                set_mapping(gp_shoulderl, 4, __INPUT_MAPPING.BUTTON, "leftshoulder");
                set_mapping(gp_shoulderr, 6, __INPUT_MAPPING.BUTTON, "rightshoulder");

                set_mapping(gp_stickl, 10, __INPUT_MAPPING.BUTTON, "leftstick");
        
                var _mapping = set_mapping(gp_axislh, 1, __INPUT_MAPPING.AXIS, "leftx");
                _mapping.limited_range = true;
                _mapping.reverse = true;
        
                _mapping = set_mapping(gp_axislv, 0, __INPUT_MAPPING.AXIS, "lefty").limited_range = true;
        
                return;
            break;
            
            case "HIDAtariVCSClassic":
                __input_trace("Overriding mapping to Atari VCS Classic");
        
                set_mapping(gp_face1, 0, __INPUT_MAPPING.BUTTON, "a");
                set_mapping(gp_face2, 1, __INPUT_MAPPING.BUTTON, "b");        
        
                set_mapping(gp_select, 2, __INPUT_MAPPING.BUTTON, "back");
                set_mapping(gp_start,  3, __INPUT_MAPPING.BUTTON, "start");
        
                set_mapping(gp_padu, 0, __INPUT_MAPPING.HAT, "dpup"   ).hat_mask = 1;
                set_mapping(gp_padr, 0, __INPUT_MAPPING.HAT, "dpright").hat_mask = 2;
                set_mapping(gp_padd, 0, __INPUT_MAPPING.HAT, "dpdown" ).hat_mask = 4;
                set_mapping(gp_padl, 0, __INPUT_MAPPING.HAT, "dpleft" ).hat_mask = 8;
        
                if (INPUT_SDL2_ALLOW_EXTENDED) set_mapping(gp_guide,  4, __INPUT_MAPPING.BUTTON, "guide");
                
                return;
            break;
            
            case "HIDWiiRemote":
                __input_trace("Overriding mapping to Wii Remote");
                
                set_mapping(gp_padl, 5, __INPUT_MAPPING.BUTTON, "dpleft");
                set_mapping(gp_padd, 6, __INPUT_MAPPING.BUTTON, "dpdown");
                set_mapping(gp_padu, 7, __INPUT_MAPPING.BUTTON, "dpup");
                set_mapping(gp_padr, 8, __INPUT_MAPPING.BUTTON, "dpright");
        
                set_mapping(gp_face1,  9, __INPUT_MAPPING.BUTTON, "a");
                set_mapping(gp_face2, 10, __INPUT_MAPPING.BUTTON, "b");
    
                set_mapping(gp_shoulderl,  0, __INPUT_MAPPING.BUTTON, "leftshoulder");
                set_mapping(gp_shoulderlb, 1, __INPUT_MAPPING.BUTTON, "lefttrigger");
        
                set_mapping(gp_select, 4, __INPUT_MAPPING.BUTTON, "back");
                set_mapping(gp_start,  3, __INPUT_MAPPING.BUTTON, "start");
    
                if (INPUT_SDL2_ALLOW_EXTENDED) set_mapping(gp_guide, 2, __INPUT_MAPPING.BUTTON, "guide");
                
                return;
            break;
            
            case "HIDWiiClassic":            
                __input_trace("Overriding mapping to Wii Classic");
                
                set_mapping(gp_padu, 11, __INPUT_MAPPING.BUTTON, "dpup");
                set_mapping(gp_padl, 12, __INPUT_MAPPING.BUTTON, "dpleft");
                set_mapping(gp_padd, 14, __INPUT_MAPPING.BUTTON, "dpdown");
                set_mapping(gp_padr, 13, __INPUT_MAPPING.BUTTON, "dpright");
        
                set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
                set_mapping(gp_face2, 0, __INPUT_MAPPING.BUTTON, "b");
                set_mapping(gp_face3, 3, __INPUT_MAPPING.BUTTON, "x");
                set_mapping(gp_face4, 2, __INPUT_MAPPING.BUTTON, "y");
    
                set_mapping(gp_shoulderl, 4, __INPUT_MAPPING.BUTTON, "leftshoulder");
                set_mapping(gp_shoulderr, 5, __INPUT_MAPPING.BUTTON, "rightshoulder");
    
                set_mapping(gp_shoulderlb, 6, __INPUT_MAPPING.BUTTON, "lefttrigger");
                set_mapping(gp_shoulderrb, 7, __INPUT_MAPPING.BUTTON, "righttrigger");
        
                set_mapping(gp_select, 10, __INPUT_MAPPING.BUTTON, "back");
                set_mapping(gp_start,   9, __INPUT_MAPPING.BUTTON, "start");
    
                if (INPUT_SDL2_ALLOW_EXTENDED) set_mapping(gp_guide, 8, __INPUT_MAPPING.BUTTON, "guide");
                
                return;
            break;
        }
    }
    
    #endregion
    
    #region Nintendo Controllers on Android (hid-nintendo, Mayflash)

    if (os_type == os_android)
    {
        if (guid == "4e696e74656e646f2053776974636820") //"Nintendo Switch "
        {
            if (description == "Nintendo Switch Pro Controller")
            {
                set_mapping(gp_face1, 0, __INPUT_MAPPING.BUTTON, "a");
                set_mapping(gp_face2, 1, __INPUT_MAPPING.BUTTON, "b");
                set_mapping(gp_face3, 2, __INPUT_MAPPING.BUTTON, "x");
                set_mapping(gp_face4, 3, __INPUT_MAPPING.BUTTON, "y");

                set_mapping(gp_shoulderl,   9, __INPUT_MAPPING.BUTTON, "leftshoulder");
                set_mapping(gp_shoulderr,  10, __INPUT_MAPPING.BUTTON, "rightshoulder");
                set_mapping(gp_shoulderlb, 17, __INPUT_MAPPING.BUTTON, "lefttrigger");
                set_mapping(gp_shoulderrb, 18, __INPUT_MAPPING.BUTTON, "righttrigger");

                set_mapping(gp_stickl, 7, __INPUT_MAPPING.BUTTON, "leftstick");
                set_mapping(gp_stickr, 8, __INPUT_MAPPING.BUTTON, "rightstick");

                set_mapping(gp_select, 14, __INPUT_MAPPING.BUTTON, "back");
                set_mapping(gp_start,   6, __INPUT_MAPPING.BUTTON, "start");

                set_mapping(gp_padu, 0, __INPUT_MAPPING.HAT, "dpup"   ).hat_mask = 1;
                set_mapping(gp_padr, 0, __INPUT_MAPPING.HAT, "dpright").hat_mask = 2;
                set_mapping(gp_padd, 0, __INPUT_MAPPING.HAT, "dpdown" ).hat_mask = 4;
                set_mapping(gp_padl, 0, __INPUT_MAPPING.HAT, "dpleft" ).hat_mask = 8;

                set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx");
                set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty");
                set_mapping(gp_axisrh, 2, __INPUT_MAPPING.AXIS, "rightx");
                set_mapping(gp_axisrv, 3, __INPUT_MAPPING.AXIS, "righty");

                if (INPUT_SDL2_ALLOW_EXTENDED) set_mapping(gp_misc1, 5, __INPUT_MAPPING.BUTTON, "misc1");

                return;
            }

            if (description == "Nintendo Switch Right Joy-Con")
            {
                set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
                set_mapping(gp_face2, 2, __INPUT_MAPPING.BUTTON, "b");
                set_mapping(gp_face3, 0, __INPUT_MAPPING.BUTTON, "x");
                set_mapping(gp_face4, 3, __INPUT_MAPPING.BUTTON, "y");

                set_mapping(gp_shoulderl,  9, __INPUT_MAPPING.BUTTON, "leftshoulder");
                set_mapping(gp_shoulderr, 17, __INPUT_MAPPING.BUTTON, "rightshoulder");

                set_mapping(gp_select, 5, __INPUT_MAPPING.BUTTON, "back");
                set_mapping(gp_start,  6, __INPUT_MAPPING.BUTTON, "start");

                set_mapping(gp_stickl, 8, __INPUT_MAPPING.BUTTON, "leftstick");

                set_mapping(gp_axislh, 1, __INPUT_MAPPING.AXIS, "leftx").reverse = true;
                set_mapping(gp_axislv, 0, __INPUT_MAPPING.AXIS, "lefty");

                return;
            }
        }
    
        if (guid == "484a5a204d6179666c61736820576969") //"HJZ Mayflash Wii"
        {
            if (description == "HJZ Mayflash WiiU Pro Game Controller Adapter")
            {
                __input_trace("Setting WiiU Pro Adapter mapping");

                set_mapping(gp_face3, 21, __INPUT_MAPPING.BUTTON, "x");
                set_mapping(gp_face1, 22, __INPUT_MAPPING.BUTTON, "a");
                set_mapping(gp_face2, 23, __INPUT_MAPPING.BUTTON, "b");
                set_mapping(gp_face4, 24, __INPUT_MAPPING.BUTTON, "y");

                set_mapping(gp_shoulderl,  25, __INPUT_MAPPING.BUTTON, "leftshoulder");
                set_mapping(gp_shoulderr,  26, __INPUT_MAPPING.BUTTON, "rightshoulder");
                set_mapping(gp_shoulderlb, 27, __INPUT_MAPPING.BUTTON, "lefttrigger");
                set_mapping(gp_shoulderrb, 28, __INPUT_MAPPING.BUTTON, "righttrigger");

                set_mapping(gp_select, 29, __INPUT_MAPPING.BUTTON, "back");
                set_mapping(gp_start,  30, __INPUT_MAPPING.BUTTON, "start");

                set_mapping(gp_stickl, 31, __INPUT_MAPPING.BUTTON, "leftstick");
                set_mapping(gp_stickr,  0, __INPUT_MAPPING.BUTTON, "rightstick");

                set_mapping(gp_padu, 0, __INPUT_MAPPING.HAT, "dpup"   ).hat_mask = 1;
                set_mapping(gp_padr, 0, __INPUT_MAPPING.HAT, "dpright").hat_mask = 2;
                set_mapping(gp_padd, 0, __INPUT_MAPPING.HAT, "dpdown" ).hat_mask = 4;
                set_mapping(gp_padl, 0, __INPUT_MAPPING.HAT, "dpleft" ).hat_mask = 8;

                set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx");
                set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty");
                set_mapping(gp_axisrh, 2, __INPUT_MAPPING.AXIS, "rightx");
                set_mapping(gp_axisrv, 3, __INPUT_MAPPING.AXIS, "righty");
                
                return;
            }

            if (description == "HJZ Mayflash Wiimote PC Adapter")
            {
                __input_trace("Setting DolphinBar mapping");

                set_mapping(gp_face3, 21, __INPUT_MAPPING.BUTTON, "x");
                set_mapping(gp_face4, 22, __INPUT_MAPPING.BUTTON, "y");
                set_mapping(gp_face1, 23, __INPUT_MAPPING.BUTTON, "a");
                set_mapping(gp_face2, 24, __INPUT_MAPPING.BUTTON, "b");

                set_mapping(gp_shoulderl,  25, __INPUT_MAPPING.BUTTON, "leftshoulder");
                set_mapping(gp_shoulderr,  26, __INPUT_MAPPING.BUTTON, "rightshoulder");
                set_mapping(gp_shoulderlb, 27, __INPUT_MAPPING.BUTTON, "lefttrigger");
                set_mapping(gp_shoulderrb, 28, __INPUT_MAPPING.BUTTON, "righttrigger");

                set_mapping(gp_select, 29, __INPUT_MAPPING.BUTTON, "back");
                set_mapping(gp_start,  30, __INPUT_MAPPING.BUTTON, "start");

                set_mapping(gp_padu, 0, __INPUT_MAPPING.HAT, "dpup"   ).hat_mask = 1;
                set_mapping(gp_padr, 0, __INPUT_MAPPING.HAT, "dpright").hat_mask = 2;
                set_mapping(gp_padd, 0, __INPUT_MAPPING.HAT, "dpdown" ).hat_mask = 4;
                set_mapping(gp_padl, 0, __INPUT_MAPPING.HAT, "dpleft" ).hat_mask = 8;

                set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx");
                set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty");
                set_mapping(gp_axisrh, 2, __INPUT_MAPPING.AXIS, "rightx");
                set_mapping(gp_axisrv, 3, __INPUT_MAPPING.AXIS, "righty");

                if (INPUT_SDL2_ALLOW_EXTENDED) set_mapping(gp_guide, 0, __INPUT_MAPPING.BUTTON, "guide");
                
                return;
            }
        }
    }

    #endregion
    
    #region Nintendo Switch Controllers on iOS

    if ((os_type == os_ios) || (os_type == os_tvos))
    {
        if ((raw_type == "SwitchJoyConPair") || (raw_type == "CommunityLikeSwitch"))
        {
            set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
            set_mapping(gp_face2, 0, __INPUT_MAPPING.BUTTON, "b");      
            set_mapping(gp_face3, 3, __INPUT_MAPPING.BUTTON, "x");
            set_mapping(gp_face4, 2, __INPUT_MAPPING.BUTTON, "y");
            
            set_mapping(gp_shoulderl,   4, __INPUT_MAPPING.BUTTON, "leftshoulder");
            set_mapping(gp_shoulderr,   5, __INPUT_MAPPING.BUTTON, "rightshoulder");
            set_mapping(gp_shoulderlb, 21, __INPUT_MAPPING.BUTTON, "lefttrigger");
            set_mapping(gp_shoulderrb, 22, __INPUT_MAPPING.BUTTON, "righttrigger");
            
            set_mapping(gp_select, 25, __INPUT_MAPPING.BUTTON, "back");
            set_mapping(gp_start,   6, __INPUT_MAPPING.BUTTON, "start");
            
            set_mapping(gp_stickl, 24, __INPUT_MAPPING.BUTTON, "leftstick");
            set_mapping(gp_stickr, 23, __INPUT_MAPPING.BUTTON, "rightstick");
            
            set_mapping(gp_padu,  7, __INPUT_MAPPING.BUTTON, "dpup");
            set_mapping(gp_padd,  8, __INPUT_MAPPING.BUTTON, "dpdown");
            set_mapping(gp_padl,  9, __INPUT_MAPPING.BUTTON, "dpleft");
            set_mapping(gp_padr, 10, __INPUT_MAPPING.BUTTON, "dpright");
            
            set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx");
            set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty");
            set_mapping(gp_axisrh, 2, __INPUT_MAPPING.AXIS, "rightx");
            set_mapping(gp_axisrv, 3, __INPUT_MAPPING.AXIS, "righty");
        }
        else if ((raw_type == "SwitchJoyConLeft") || (raw_type == "SwitchJoyConRight"))
        {
            set_mapping(gp_face1, 0, __INPUT_MAPPING.BUTTON, "a");
            set_mapping(gp_face2, 2, __INPUT_MAPPING.BUTTON, "b");      
            set_mapping(gp_face3, 1, __INPUT_MAPPING.BUTTON, "x");
            set_mapping(gp_face4, 3, __INPUT_MAPPING.BUTTON, "y");
            
            set_mapping(gp_shoulderl, 4, __INPUT_MAPPING.BUTTON, "leftshoulder");
            set_mapping(gp_shoulderr, 5, __INPUT_MAPPING.BUTTON, "rightshoulder");
            
            set_mapping(gp_select, 6, __INPUT_MAPPING.BUTTON, "back");
            set_mapping(gp_start, 0, undefined, "start");
            
            var _mapping = set_mapping(gp_axislh, undefined, __INPUT_MAPPING.BUTTON_TO_AXIS, "leftx");
            _mapping.raw_negative = 9;
            _mapping.raw_positive = 10;
            
            _mapping = set_mapping(gp_axislv, undefined, __INPUT_MAPPING.BUTTON_TO_AXIS, "lefty");
            _mapping.raw_negative = 7;
            _mapping.raw_positive = 8;
        }
            
        return;
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
                    var _input_reverse  = false;
                    var _input_negative = false;
                    var _input_positive = false;
                
                    if (string_char_at(_entry_1, string_length(_entry_1)) == "~")
                    {
                        _entry_1 = string_delete(_entry_1, string_length(_entry_1), 1);

                        if ((_gm_constant == gp_axislh) || (_gm_constant == gp_axislv)
                        ||  (_gm_constant == gp_axisrh) || (_gm_constant == gp_axisrv))
                        {
                            _input_reverse = true;
                        }
                        else
                        {
                            _input_invert = true;
                        }
                    }
                
                    var _raw_type = undefined;
                    do
                    {
                        var _char = string_char_at(_entry_1, 1);
                        _entry_1 = string_delete(_entry_1, 1, 1);
                    
                        switch(_char)
                        {
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
                        if (_input_reverse ) _mapping.reverse        = true;
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
            if ((os_type == os_android) && (hat_count > 0) && (vendor + product == ""))
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
            if (((os_type == os_windows) || (os_type == os_macosx))
            && (simple_type == "ps4") && (raw_type != "XInputPS4Controller")
            && (mapping_gm_to_raw[$ string(gp_touchpad)] == undefined))
            {                
                var _matched = 0;
                var _mapping = undefined;
                var _button_array = [gp_face3, gp_face1, gp_face2, gp_face4];
                var _offset = ((mac_cleared_mapping && (os_type == os_macosx)) ? 17 : 0);

                repeat(array_length(_button_array))
                {
                    //Check mapping match (b0 - b3)
                    _mapping = mapping_gm_to_raw[$ string(_button_array[_matched])];
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
            if ((raw_type == "CommunityOuya") && ((os_type == os_windows) || (os_type == os_linux)))
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
