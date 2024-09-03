// Feather disable all
/// This function should be called in the scope of a gamepad class

function __input_gamepad_set_mapping()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    __custom_mapping = false;
    
    if (__blacklisted) 
    {
        __set_custom_mapping();
        __mapping_gm_to_raw = {};
        __mapping_raw_to_gm = {};
        __mapping_array     = [];
        return;
    }
    
    #region Switch
    
    if (__INPUT_ON_SWITCH)
    {
        //Disallow dpad input from single Joy-Cons. This happens when moving the thumbstick around in horizontal mode
        if ((__raw_type != "SwitchJoyConLeft") && (__raw_type != "SwitchJoyConRight"))
        {
            __set_mapping(gp_padu, gp_padu, __INPUT_MAPPING.BUTTON, "dpup");
            __set_mapping(gp_padd, gp_padd, __INPUT_MAPPING.BUTTON, "dpdown");
            __set_mapping(gp_padl, gp_padl, __INPUT_MAPPING.BUTTON, "dpleft");
            __set_mapping(gp_padr, gp_padr, __INPUT_MAPPING.BUTTON, "dpright");
        }
        
        if ((__raw_type == "SwitchJoyConLeft") || (__raw_type == "SwitchJoyConRight"))
        {
            if (INPUT_SWITCH_HORIZONTAL_HOLDTYPE)
            {
                //Single Joy-Cons in horizontal report L/R/ZL/ZR as shoulder buttons even though they rest in the player's palm. No idea why, but we disallow that
                __set_mapping(gp_shoulderl, 6, __INPUT_MAPPING.BUTTON, "leftshoulder");
                __set_mapping(gp_shoulderr, 7, __INPUT_MAPPING.BUTTON, "rightshoulder");
            }
            else
            {
                //SL/SR are still technically active in vertical mode too but that's silly so we ignore them
                __set_mapping(gp_shoulderl,  8, __INPUT_MAPPING.BUTTON, "leftshoulder");
                __set_mapping(gp_shoulderlb, 9, __INPUT_MAPPING.BUTTON, "lefttrigger");
            }
        }
        else
        {
            //Even in other gamepad modes Switch triggers are digital rather than analogue so we treat those as strict buttons
            __set_mapping(gp_shoulderl,  6, __INPUT_MAPPING.BUTTON, "leftshoulder");
            __set_mapping(gp_shoulderr,  7, __INPUT_MAPPING.BUTTON, "rightshoulder");
            __set_mapping(gp_shoulderlb, 8, __INPUT_MAPPING.BUTTON, "lefttrigger");
            __set_mapping(gp_shoulderrb, 9, __INPUT_MAPPING.BUTTON, "righttrigger");
        }
        
        __set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
        __set_mapping(gp_face2, 0, __INPUT_MAPPING.BUTTON, "b");
        __set_mapping(gp_face3, 3, __INPUT_MAPPING.BUTTON, "x");
        __set_mapping(gp_face4, 2, __INPUT_MAPPING.BUTTON, "y");
                                  
        __set_mapping(gp_start, 10, __INPUT_MAPPING.BUTTON, "start");
        
        //No select button exists for single Joy-Cons so ignore this entirely
        if ((__raw_type != "SwitchJoyConLeft") && (__raw_type != "SwitchJoyConRight"))
        {
            __set_mapping(gp_select, 11, __INPUT_MAPPING.BUTTON, "back");
        }
        
        __set_thumbstick_axis_mapping();
        __set_mapping(gp_stickl, 4, __INPUT_MAPPING.BUTTON, "leftstick");
        __set_mapping(gp_stickr, 5, __INPUT_MAPPING.BUTTON, "rightstick");
        
        return;
    }
    
    #endregion
    
    #region Web
    
    if (__INPUT_ON_OPERAGX)
    {
        if ((__guessed_type == true) && (__simple_type == "switch"))
        {
            __set_mapping(gp_face2,  0, __INPUT_MAPPING.BUTTON, "b");
            __set_mapping(gp_face1,  1, __INPUT_MAPPING.BUTTON, "a");
            __set_mapping(gp_face4, 12, __INPUT_MAPPING.BUTTON, "y");
            __set_mapping(gp_face3, 13, __INPUT_MAPPING.BUTTON, "x");
        }
        else
        {
            __set_mapping(gp_face1,  0, __INPUT_MAPPING.BUTTON, "a");
            __set_mapping(gp_face2,  1, __INPUT_MAPPING.BUTTON, "b");
            __set_mapping(gp_face3, 12, __INPUT_MAPPING.BUTTON, "x");
            __set_mapping(gp_face4, 13, __INPUT_MAPPING.BUTTON, "y");
        }
        
        __set_mapping(gp_shoulderl,   6, __INPUT_MAPPING.BUTTON, "leftshoulder");
        __set_mapping(gp_shoulderr,   9, __INPUT_MAPPING.BUTTON, "rightshoulder");
        __set_mapping(gp_shoulderlb, 14, __INPUT_MAPPING.BUTTON, "lefttrigger");
        __set_mapping(gp_shoulderrb, 15, __INPUT_MAPPING.BUTTON, "righttrigger");
        
        __set_mapping(gp_select, 11, __INPUT_MAPPING.BUTTON, "back");
        __set_mapping(gp_start,   8, __INPUT_MAPPING.BUTTON, "start");
        __set_mapping(gp_stickl,  7, __INPUT_MAPPING.BUTTON, "leftstick");
        __set_mapping(gp_stickr, 10, __INPUT_MAPPING.BUTTON, "rightstick");
        
        __set_mapping(gp_padu, 5, __INPUT_MAPPING.BUTTON, "dpup");
        __set_mapping(gp_padd, 2, __INPUT_MAPPING.BUTTON, "dpdown");
        __set_mapping(gp_padl, 3, __INPUT_MAPPING.BUTTON, "dpleft");
        __set_mapping(gp_padr, 4, __INPUT_MAPPING.BUTTON, "dpright");
        
        __set_thumbstick_axis_mapping();
        
        return;
    }
    
    if (INPUT_ON_WEB)
    {
        __set_face_button_mapping();
        __set_thumbstick_axis_mapping();
        
        __set_mapping(gp_shoulderl,  4, __INPUT_MAPPING.BUTTON, "leftshoulder");
        __set_mapping(gp_shoulderr,  5, __INPUT_MAPPING.BUTTON, "rightshoulder");
        __set_mapping(gp_shoulderlb, 6, __INPUT_MAPPING.BUTTON, "lefttrigger");
        __set_mapping(gp_shoulderrb, 7, __INPUT_MAPPING.BUTTON, "righttrigger");
        
        __set_mapping(gp_select,  8, __INPUT_MAPPING.BUTTON, "back");
        __set_mapping(gp_start,   9, __INPUT_MAPPING.BUTTON, "start");
        __set_mapping(gp_stickl, 10, __INPUT_MAPPING.BUTTON, "leftstick");
        __set_mapping(gp_stickr, 11, __INPUT_MAPPING.BUTTON, "rightstick");
        
        if (__INPUT_ON_LINUX && (os_browser == browser_firefox))
        {
            //ಠ_ಠ
            var _mapping = __set_mapping(gp_padr, 6, __INPUT_MAPPING.AXIS, "dpright")
            _mapping.__clamp_positive = true;
            
            _mapping = __set_mapping(gp_padd, 7, __INPUT_MAPPING.AXIS, "dpdown" )
            _mapping = __clamp_positive = true;
            
            _mapping = __set_mapping(gp_padl, 6, __INPUT_MAPPING.AXIS, "dpleft");
            _mapping.__clamp_negative = true;
            _mapping.__reverse = true;
            
            _mapping = __set_mapping(gp_padu, 7, __INPUT_MAPPING.AXIS, "dpup");
            _mapping.__clamp_negative = true;
            _mapping.__reverse = true;
        }
        else
        {
            __set_mapping(gp_padu, 12, __INPUT_MAPPING.BUTTON, "dpup");
            __set_mapping(gp_padd, 13, __INPUT_MAPPING.BUTTON, "dpdown");
            __set_mapping(gp_padl, 14, __INPUT_MAPPING.BUTTON, "dpleft");
            __set_mapping(gp_padr, 15, __INPUT_MAPPING.BUTTON, "dpright");
        }
        
        __set_mapping(gp_guide, 16, __INPUT_MAPPING.BUTTON, "guide");
            
        if ((__simple_type == "ps4")  || (__simple_type == "ps5"))
        {
            __set_mapping(gp_touchpad, 17, __INPUT_MAPPING.BUTTON, "touchpad");   
        }
        else
        {
            __set_mapping(gp_misc1, 17, __INPUT_MAPPING.BUTTON, "misc1");
        }
        
        return;
    }
    
    #endregion
    
    #region XInput
    
    if (__xinput)
    {
        //Default XInput mapping for Windows. This mapping is super common!
        __set_mapping(gp_padu,   0, __INPUT_MAPPING.BUTTON, "dpup");
        __set_mapping(gp_padd,   1, __INPUT_MAPPING.BUTTON, "dpdown");
        __set_mapping(gp_padl,   2, __INPUT_MAPPING.BUTTON, "dpleft");
        __set_mapping(gp_padr,   3, __INPUT_MAPPING.BUTTON, "dpright");
        __set_mapping(gp_start,  4, __INPUT_MAPPING.BUTTON, "start");
        __set_mapping(gp_select, 5, __INPUT_MAPPING.BUTTON, "back");
            
        __set_mapping(gp_stickl,    6, __INPUT_MAPPING.BUTTON, "leftstick");
        __set_mapping(gp_stickr,    7, __INPUT_MAPPING.BUTTON, "rightstick");
        __set_mapping(gp_shoulderl, 8, __INPUT_MAPPING.BUTTON, "leftshoulder");
        __set_mapping(gp_shoulderr, 9, __INPUT_MAPPING.BUTTON, "rightshoulder");
            
        __set_mapping(gp_face1, 12, __INPUT_MAPPING.BUTTON, "a");
        __set_mapping(gp_face2, 13, __INPUT_MAPPING.BUTTON, "b");
        __set_mapping(gp_face3, 14, __INPUT_MAPPING.BUTTON, "x");
        __set_mapping(gp_face4, 15, __INPUT_MAPPING.BUTTON, "y");
        
        __set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx");
        __set_mapping(gp_axisrh, 2, __INPUT_MAPPING.AXIS, "rightx");
        
        var _mapping = __set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty"); 
        _mapping.__reverse = true;

        _mapping = __set_mapping(gp_axisrv, 3, __INPUT_MAPPING.AXIS, "righty");
        _mapping.__reverse = true;
        
        var _mapping_lt = __set_mapping(gp_shoulderlb, __XINPUT_AXIS_LT, __INPUT_MAPPING.AXIS, "lefttrigger");
        var _mapping_rt = __set_mapping(gp_shoulderrb, __XINPUT_AXIS_RT, __INPUT_MAPPING.AXIS, "righttrigger");
        
        //Scale trigger axes. Recalibrated later if value falls outside range
        if (is_numeric(__steam_handle))
        {
            //Scale per "Normal" XInput offset
            __xinput_trigger_range = 255/256;
        }
        else
        {
            //Scale per Xbox One/Series controllers over USB
            __xinput_trigger_range = 63/256;
        }

        _mapping_lt.__scale = 1/__xinput_trigger_range;
        _mapping_rt.__scale = 1/__xinput_trigger_range;
        
        return;
    }
    
    #endregion
    
    #region Raw type overrides

    var _vendor_and_product = __vendor + __product;
    switch(__raw_type)
    {
        #region Stadia Controller on Windows

        case "CommunityStadia":
            if (__INPUT_ON_WINDOWS)
            {
                //Analogue triggers and right stick mapping depends on Windows Registry setting
                if (!__INPUT_SILENT) __input_trace("Setting default Stadia controller mapping");                
                
                __set_face_button_mapping();
                
                __set_mapping(gp_shoulderl, 4, __INPUT_MAPPING.BUTTON, "leftshoulder");
                __set_mapping(gp_shoulderr, 5, __INPUT_MAPPING.BUTTON, "rightshoulder");
                 
                __set_mapping(gp_stickl, 6, __INPUT_MAPPING.BUTTON, "leftstick");
                __set_mapping(gp_stickr, 7, __INPUT_MAPPING.BUTTON, "rightstick");
                 
                __set_mapping(gp_select, 8, __INPUT_MAPPING.BUTTON, "back");
                __set_mapping(gp_start,  9, __INPUT_MAPPING.BUTTON, "start");
                 
                __set_mapping(gp_guide, 10, __INPUT_MAPPING.BUTTON, "guide"); //Stadia button
                //__set_mapping(???,    13, __INPUT_MAPPING.BUTTON,  ???);    //Assistant button, no SDL key for this
                __set_mapping(gp_misc1, 14, __INPUT_MAPPING.BUTTON, "misc1"); //Capture button
                
                __set_dpad_hat_mapping();        
                __set_thumbstick_axis_mapping(true);        
                  
                //Set default mapping with digital triggers, test later
                __stadia_trigger_test = true;
                    
                __set_mapping(gp_shoulderrb, 11, __INPUT_MAPPING.BUTTON, "righttrigger");
                __set_mapping(gp_shoulderlb, 12, __INPUT_MAPPING.BUTTON, "lefttrigger");
                
                __set_mapping(gp_axisrh, 3, __INPUT_MAPPING.AXIS, "rightx");
                __set_mapping(gp_axisrv, 4, __INPUT_MAPPING.AXIS, "righty");
                
                return;
            }
        break;

        #endregion


        #region Unofficial Windows driver for official Wii U GCN USB

        case "CommunityGameCube":
            if ((_vendor_and_product == "3412adbe") && __INPUT_ON_WINDOWS)
            {
                //Userland vJoy device feeder for WUP-028
                if (!__INPUT_SILENT) __input_trace("Setting GameCube adapter slot to alternate mapping");
                
                __set_mapping(gp_face1, 0, __INPUT_MAPPING.BUTTON, "a");
                __set_mapping(gp_face3, 1, __INPUT_MAPPING.BUTTON, "x");
                __set_mapping(gp_face2, 2, __INPUT_MAPPING.BUTTON, "b");
                __set_mapping(gp_face4, 3, __INPUT_MAPPING.BUTTON, "y");
                
                __set_mapping(gp_shoulderr, 4, __INPUT_MAPPING.BUTTON, "rightshoulder");
                
                ////Dual-stage trigger mapping (semantically incorrect)
                //__set_mapping(gp_paddle2, 5, __INPUT_MAPPING.BUTTON, "paddle2");
                //__set_mapping(gp_paddle1, 6, __INPUT_MAPPING.BUTTON, "paddle1");        
                 
                __set_mapping(gp_padu,  8, __INPUT_MAPPING.BUTTON, "dpup");
                __set_mapping(gp_padd,  9, __INPUT_MAPPING.BUTTON, "dpdown");
                __set_mapping(gp_padl, 10, __INPUT_MAPPING.BUTTON, "dpleft");
                __set_mapping(gp_padr, 11, __INPUT_MAPPING.BUTTON, "dpright");
                
                __set_thumbstick_axis_mapping(true);        
                __set_mapping(gp_axisrh, 3, __INPUT_MAPPING.AXIS, "rightx");
                __set_mapping(gp_axisrv, 4, __INPUT_MAPPING.AXIS, "righty");
                
                var _mapping = __set_mapping(gp_shoulderlb, 2, __INPUT_MAPPING.AXIS, "lefttrigger");
                _mapping.__clamp_positive = true;

                _mapping = __set_mapping(gp_shoulderrb, 5, __INPUT_MAPPING.AXIS, "righttrigger");
                _mapping.__clamp_positive = true;  
                
                return;
            }
        break;

        #endregion


        #region MFi controller on Windows

        case "AppleController":
            if ((__guessed_type == false) && __INPUT_ON_WINDOWS)
            {
                //MFi controllers have unreliable VID+PID, type is set on other indicators
                if (!__INPUT_SILENT) __input_trace("Setting MFi controller mapping");
                
                __set_mapping(gp_padl, 0, __INPUT_MAPPING.BUTTON, "dpleft");
                __set_mapping(gp_padd, 1, __INPUT_MAPPING.BUTTON, "dpdown");
                __set_mapping(gp_padr, 2, __INPUT_MAPPING.BUTTON, "dpright");
                __set_mapping(gp_padu, 3, __INPUT_MAPPING.BUTTON, "dpup");
                
                __set_mapping(gp_face1, 4, __INPUT_MAPPING.BUTTON, "a");
                __set_mapping(gp_face2, 5, __INPUT_MAPPING.BUTTON, "b");
                __set_mapping(gp_face3, 6, __INPUT_MAPPING.BUTTON, "x");
                __set_mapping(gp_face4, 7, __INPUT_MAPPING.BUTTON, "y");
            
                __set_mapping(gp_shoulderl, 8, __INPUT_MAPPING.BUTTON, "leftshoulder");
                __set_mapping(gp_shoulderr, 9, __INPUT_MAPPING.BUTTON, "rightshoulder");
            
                __set_mapping(gp_stickr, 10, __INPUT_MAPPING.BUTTON, "rightstick");
                __set_mapping(gp_stickl, 11, __INPUT_MAPPING.BUTTON, "leftstick");
                
                __set_mapping(gp_select, 13, __INPUT_MAPPING.BUTTON, "back");
                __set_mapping(gp_start,  14, __INPUT_MAPPING.BUTTON, "start");
            
                __set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx");
                __set_mapping(gp_axisrh, 2, __INPUT_MAPPING.AXIS, "rightx");
                
                //No trigger data :-(
                __set_mapping(gp_shoulderlb, 0, undefined, "lefttrigger");
                __set_mapping(gp_shoulderrb, 0, undefined, "righttrigger");
                
                var _mapping = __set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty");
                _mapping.__reverse = true;

                _mapping = __set_mapping(gp_axisrv, 3, __INPUT_MAPPING.AXIS, "righty");
                _mapping.__reverse = true;
            
                __set_mapping(gp_guide, 12, __INPUT_MAPPING.BUTTON, "guide");
                
                return;
            }
        break;

        #endregion


        #region N64 controller overrides

        case "CommunityN64":
            if (__guessed_type == true) break;

            switch(_vendor_and_product)
            {
                #region Mayflash N64 Adapter on MacOS
                
                case "8f0e1330":
                    if (__INPUT_ON_MACOS)
                    {
                        if (!__INPUT_SILENT) __input_trace("Overriding mapping to N64");        
                       
                        __set_mapping(gp_face1, 3, __INPUT_MAPPING.BUTTON, "a");
                        __set_mapping(gp_face2, 5, __INPUT_MAPPING.BUTTON, "b");

                        __set_mapping(gp_shoulderl,  13, __INPUT_MAPPING.BUTTON, "leftshoulder")
                        __set_mapping(gp_shoulderr,  15, __INPUT_MAPPING.BUTTON, "rightshoulder");
                        __set_mapping(gp_shoulderlb, 17, __INPUT_MAPPING.BUTTON, "lefttrigger");
                        __set_mapping(gp_start,      19, __INPUT_MAPPING.BUTTON, "start");

                        __set_mapping(gp_padu, 25, __INPUT_MAPPING.BUTTON, "dpup"   );
                        __set_mapping(gp_padr, 27, __INPUT_MAPPING.BUTTON, "dpright");
                        __set_mapping(gp_padd, 29, __INPUT_MAPPING.BUTTON, "dpdown" );
                        __set_mapping(gp_padl, 31, __INPUT_MAPPING.BUTTON, "dpleft" );

                        __set_mapping(gp_axislh, 1, __INPUT_MAPPING.AXIS,  "leftx");
                        __set_mapping(gp_axislv, 3, __INPUT_MAPPING.AXIS,  "lefty");
                        __set_mapping(gp_axisrv, 5, __INPUT_MAPPING.AXIS, "righty");
                        
                        var _mapping = __set_mapping(gp_axisrh, 7, __INPUT_MAPPING.AXIS, "rightx")
                        _mapping.__reverse = true;
                        
                        __set_mapping(gp_shoulderrb, 0, undefined, "righttrigger");
                        __set_mapping(gp_select,     0, undefined, "back");
                        
                        return;
                    }
                break;
                
                #endregion

                #region retro-bit Tribute 64 on Windows and Linux

                case "63257505":
                    if (__INPUT_ON_LINUX || __INPUT_ON_WINDOWS)
                    {
                        if (!__INPUT_SILENT) __input_trace("Overriding mapping to N64");

                        __set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
                        __set_mapping(gp_face2, 2, __INPUT_MAPPING.BUTTON, "b");

                        __set_mapping(gp_start, 12, __INPUT_MAPPING.BUTTON, "start");

                        __set_mapping(gp_shoulderl,  4, __INPUT_MAPPING.BUTTON, "leftshoulder");
                        __set_mapping(gp_shoulderr,  5, __INPUT_MAPPING.BUTTON, "rightshoulder");
                        __set_mapping(gp_shoulderlb, 6, __INPUT_MAPPING.BUTTON, "lefttrigger");
                        __set_mapping(gp_shoulderrb, 7, __INPUT_MAPPING.BUTTON, "righttrigger");

                        __set_dpad_hat_mapping();
                        __set_thumbstick_axis_mapping(true);

                        _mapping = __set_mapping(gp_axisrh, undefined, __INPUT_MAPPING.BUTTON_TO_AXIS, "rightx");
                        _mapping.__raw_negative = 3;
                        _mapping.__raw_positive = 8;
                        
                        _mapping = __set_mapping(gp_axisrv, undefined, __INPUT_MAPPING.BUTTON_TO_AXIS, "righty");
                        _mapping.__raw_negative = 9;
                        _mapping.__raw_positive = 0;

                        return;
                    }
                break;
                
                #endregion
            }
        break;

        #endregion


        #region Obins Anne Pro 2 on Windows MacOS and Linux

        case "CommunityAnnePro":    
            if (INPUT_ON_PC)
            {
                if (!__INPUT_SILENT) __input_trace("Overriding mapping to Obins Anne Pro 2");

                if (!__INPUT_ON_MACOS)
                {
                    var _mapping = __set_mapping(gp_shoulderlb, 0, __INPUT_MAPPING.AXIS,  "lefttrigger");
                    _mapping.__extended_range = __INPUT_ON_WINDOWS;
                    
                    _mapping = __set_mapping(gp_shoulderrb, 1, __INPUT_MAPPING.AXIS, "righttrigger");
                    _mapping.__extended_range = __INPUT_ON_WINDOWS;
                }
                
                __set_mapping(gp_axislh, 3, __INPUT_MAPPING.AXIS,   "leftx");
                
                __set_mapping(gp_shoulderl, 0, __INPUT_MAPPING.BUTTON, "leftshoulder");
                __set_mapping(gp_select,    1, __INPUT_MAPPING.BUTTON, "back");
                __set_mapping(gp_padl,      2, __INPUT_MAPPING.BUTTON, "dpleft");
                __set_mapping(gp_padu,      3, __INPUT_MAPPING.BUTTON, "dpup");
                __set_mapping(gp_padd,      4, __INPUT_MAPPING.BUTTON, "dpdown");
                __set_mapping(gp_padr,      5, __INPUT_MAPPING.BUTTON, "dpright");
                __set_mapping(gp_shoulderr, 6, __INPUT_MAPPING.BUTTON, "rightshoulder");
                __set_mapping(gp_start,     7, __INPUT_MAPPING.BUTTON, "start");
                __set_mapping(gp_face2,     8, __INPUT_MAPPING.BUTTON, "b");
                __set_mapping(gp_face4,     9, __INPUT_MAPPING.BUTTON, "y");
                __set_mapping(gp_face1,    10, __INPUT_MAPPING.BUTTON, "a");
                __set_mapping(gp_face3,    11, __INPUT_MAPPING.BUTTON, "x");
                
                return;
            }            
        break;
        
        #endregion


        #region Ouya Controller on MacOS

        case "CommunityOuya":           
            if (__INPUT_ON_MACOS)
            {
                //Ouya controller doesn't work at all in SDL on Mac, but buttons do in GM
                if (!__INPUT_SILENT) __input_trace("Setting Ouya controller mapping");
                
                __set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
                __set_mapping(gp_face2, 6, __INPUT_MAPPING.BUTTON, "b");
                __set_mapping(gp_face3, 3, __INPUT_MAPPING.BUTTON, "x");
                __set_mapping(gp_face4, 5, __INPUT_MAPPING.BUTTON, "y");
            
                __set_mapping(gp_shoulderl, 7, __INPUT_MAPPING.BUTTON, "leftshoulder");
                __set_mapping(gp_shoulderr, 8, __INPUT_MAPPING.BUTTON, "rightshoulder");                    
                            
                __set_mapping(gp_shoulderlb, 15, __INPUT_MAPPING.BUTTON, "lefttrigger");
                __set_mapping(gp_shoulderrb, 16, __INPUT_MAPPING.BUTTON, "righttrigger");
            
                __set_mapping(gp_stickl,  9, __INPUT_MAPPING.BUTTON, "leftstick");
                __set_mapping(gp_stickr, 10, __INPUT_MAPPING.BUTTON, "rightstick");

                __set_mapping(gp_padu, 11, __INPUT_MAPPING.BUTTON, "dpup"   );
                __set_mapping(gp_padr, 14, __INPUT_MAPPING.BUTTON, "dpright");
                __set_mapping(gp_padd, 12, __INPUT_MAPPING.BUTTON, "dpdown" );
                __set_mapping(gp_padl, 13, __INPUT_MAPPING.BUTTON, "dpleft" );
                            
                __set_mapping(gp_guide, 18, __INPUT_MAPPING.BUTTON, "guide");
            
                __set_mapping(gp_select, 0, undefined, "back"  );
                __set_mapping(gp_start,  0, undefined, "start" );    
                __set_mapping(gp_axislh, 0, undefined, "leftx" );
                __set_mapping(gp_axislv, 0, undefined, "lefty" );
                __set_mapping(gp_axisrh, 0, undefined, "rightx");
                __set_mapping(gp_axisrv, 0, undefined, "righty");
                    
                return;
            }
        break;
    
        #endregion


        #region NeoGeo Mini on Windows and Linux

        case "CommunityNeoGeoMini":
            if ((__guessed_type == false) && (__INPUT_ON_LINUX || __INPUT_ON_WINDOWS))
            {
                if (!__INPUT_SILENT) __input_trace("Overriding mapping to NeoGeo Mini");

                __set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
                __set_mapping(gp_face2, 0, __INPUT_MAPPING.BUTTON, "b");
                __set_mapping(gp_face3, 2, __INPUT_MAPPING.BUTTON, "x");
                __set_mapping(gp_face4, 3, __INPUT_MAPPING.BUTTON, "y");

                __set_mapping(gp_select, 8, __INPUT_MAPPING.BUTTON, "back");
                __set_mapping(gp_start,  9, __INPUT_MAPPING.BUTTON, "start");

                __set_dpad_hat_mapping();

                return;
            }
        break;

        #endregion


        #region Nintendo Switch Online Controllers on Linux

        case "CommunitySaturn":
            if ((__guessed_type == false) && __INPUT_ON_LINUX && (_vendor_and_product == "7e051720"))
            {
                if (__input_string_contains(__description, "Genesis 3btn"))
                {
                    if (!__INPUT_SILENT) __input_trace("Overriding mapping to Mega Drive 3b");
                    
                    __set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
                    __set_mapping(gp_face2, 0, __INPUT_MAPPING.BUTTON, "b");
                    
                    __set_mapping(gp_shoulderrb, 5, __INPUT_MAPPING.BUTTON, "righttrigger"); //C button
                    
                    __set_mapping(gp_select, 7, __INPUT_MAPPING.BUTTON, "back");
                    __set_mapping(gp_start,  9, __INPUT_MAPPING.BUTTON, "start");
                    
                    __set_dpad_hat_mapping();
                    
                    __set_mapping(gp_guide, 12, __INPUT_MAPPING.BUTTON, "guide");
                    
                    return;
                }
                else if (__input_string_contains(__description, "Genesis 6btn"))
                {
                    if (!__INPUT_SILENT) __input_trace("Overriding mapping to Mega Drive 6b");
                    
                    __set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
                    __set_mapping(gp_face2, 0, __INPUT_MAPPING.BUTTON, "b");      
                    __set_mapping(gp_face3, 6, __INPUT_MAPPING.BUTTON, "x");
                    __set_mapping(gp_face4, 2, __INPUT_MAPPING.BUTTON, "y");
                    
                    __set_mapping(gp_shoulderr,  4, __INPUT_MAPPING.BUTTON, "rightshoulder"); //Z button
                    __set_mapping(gp_shoulderrb, 5, __INPUT_MAPPING.BUTTON, "righttrigger");  //C button
                    
                    __set_mapping(gp_select, 7, __INPUT_MAPPING.BUTTON, "back");
                    __set_mapping(gp_start,  9, __INPUT_MAPPING.BUTTON, "start");

                    __set_dpad_hat_mapping();
                    
                    __set_mapping(gp_guide, 12, __INPUT_MAPPING.BUTTON, "guide");
                    
                    return;
                }       
            }
        break;

        #endregion


        #region Non-normative HID mappings for Linux
        
        case "HIDJoyConLeft":
            if (!__INPUT_SILENT) __input_trace("Overriding mapping to Joy-Con Left");

            __set_mapping(gp_face1,  9, __INPUT_MAPPING.BUTTON, "a");
            __set_mapping(gp_face2,  8, __INPUT_MAPPING.BUTTON, "b");
            __set_mapping(gp_face3,  7, __INPUT_MAPPING.BUTTON, "x");
            __set_mapping(gp_face4, 10, __INPUT_MAPPING.BUTTON, "y");

            __set_mapping(gp_shoulderl, 2, __INPUT_MAPPING.BUTTON, "leftshoulder");
            __set_mapping(gp_shoulderr, 4, __INPUT_MAPPING.BUTTON, "rightshoulder");

            __set_mapping(gp_select, 5, __INPUT_MAPPING.BUTTON, "back");
            __set_mapping(gp_start,  0, __INPUT_MAPPING.BUTTON, "start");

            __set_mapping(gp_stickl, 6, __INPUT_MAPPING.BUTTON, "leftstick");

            var _mapping = __set_mapping(gp_axislh, 1, __INPUT_MAPPING.AXIS, "leftx");
            _mapping.__limited_range = true;

            _mapping = __set_mapping(gp_axislv, 0, __INPUT_MAPPING.AXIS, "lefty");
            _mapping.__limited_range = true;
            _mapping.__reverse       = true;

            return;
        break;
        
        case "HIDJoyConRight":
            if (!__INPUT_SILENT) __input_trace("Overriding mapping to Joy-Con Right");

            __set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
            __set_mapping(gp_face2, 2, __INPUT_MAPPING.BUTTON, "b");
            __set_mapping(gp_face3, 0, __INPUT_MAPPING.BUTTON, "x");
            __set_mapping(gp_face4, 3, __INPUT_MAPPING.BUTTON, "y");

            __set_mapping(gp_select, 9, __INPUT_MAPPING.BUTTON, "back");
            __set_mapping(gp_start,  8, __INPUT_MAPPING.BUTTON, "start");

            __set_mapping(gp_shoulderl, 4, __INPUT_MAPPING.BUTTON, "leftshoulder");
            __set_mapping(gp_shoulderr, 6, __INPUT_MAPPING.BUTTON, "rightshoulder");

            __set_mapping(gp_stickl, 10, __INPUT_MAPPING.BUTTON, "leftstick");

            var _mapping = __set_mapping(gp_axislh, 1, __INPUT_MAPPING.AXIS, "leftx");
            _mapping.__limited_range = true;
            _mapping.__reverse = true;

            _mapping = __set_mapping(gp_axislv, 0, __INPUT_MAPPING.AXIS, "lefty")
            _mapping.__limited_range = true;

            return;
        break;
        
        case "HIDAtariVCSClassic":
            if (!__INPUT_SILENT) __input_trace("Overriding mapping to Atari VCS Classic");

            __set_mapping(gp_face1, 0, __INPUT_MAPPING.BUTTON, "a");
            __set_mapping(gp_face2, 1, __INPUT_MAPPING.BUTTON, "b");        

            __set_mapping(gp_select, 2, __INPUT_MAPPING.BUTTON, "back");
            __set_mapping(gp_start,  3, __INPUT_MAPPING.BUTTON, "start");

            __set_dpad_hat_mapping();

            __set_mapping(gp_guide,  4, __INPUT_MAPPING.BUTTON, "guide");
            
            return;
        break;
        
        case "HIDWiiRemote":
            if (!__INPUT_SILENT) __input_trace("Overriding mapping to Wii Remote");
            
            __set_mapping(gp_padl, 5, __INPUT_MAPPING.BUTTON, "dpleft");
            __set_mapping(gp_padd, 6, __INPUT_MAPPING.BUTTON, "dpdown");
            __set_mapping(gp_padu, 7, __INPUT_MAPPING.BUTTON, "dpup");
            __set_mapping(gp_padr, 8, __INPUT_MAPPING.BUTTON, "dpright");

            __set_mapping(gp_face1,  9, __INPUT_MAPPING.BUTTON, "a");
            __set_mapping(gp_face2, 10, __INPUT_MAPPING.BUTTON, "b");

            __set_mapping(gp_shoulderl,  0, __INPUT_MAPPING.BUTTON, "leftshoulder");
            __set_mapping(gp_shoulderlb, 1, __INPUT_MAPPING.BUTTON, "lefttrigger");

            __set_mapping(gp_select, 4, __INPUT_MAPPING.BUTTON, "back");
            __set_mapping(gp_start,  3, __INPUT_MAPPING.BUTTON, "start");

            __set_mapping(gp_guide, 2, __INPUT_MAPPING.BUTTON, "guide");
            
            return;
        break;
        
        case "HIDWiiClassic":
            if (!__INPUT_SILENT) __input_trace("Overriding mapping to Wii Classic");
            
            __set_mapping(gp_padu, 11, __INPUT_MAPPING.BUTTON, "dpup");
            __set_mapping(gp_padl, 12, __INPUT_MAPPING.BUTTON, "dpleft");
            __set_mapping(gp_padd, 14, __INPUT_MAPPING.BUTTON, "dpdown");
            __set_mapping(gp_padr, 13, __INPUT_MAPPING.BUTTON, "dpright");

            __set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
            __set_mapping(gp_face2, 0, __INPUT_MAPPING.BUTTON, "b");
            __set_mapping(gp_face3, 3, __INPUT_MAPPING.BUTTON, "x");
            __set_mapping(gp_face4, 2, __INPUT_MAPPING.BUTTON, "y");

            __set_mapping(gp_shoulderl, 4, __INPUT_MAPPING.BUTTON, "leftshoulder");
            __set_mapping(gp_shoulderr, 5, __INPUT_MAPPING.BUTTON, "rightshoulder");

            __set_mapping(gp_shoulderlb, 6, __INPUT_MAPPING.BUTTON, "lefttrigger");
            __set_mapping(gp_shoulderrb, 7, __INPUT_MAPPING.BUTTON, "righttrigger");

            __set_mapping(gp_select, 10, __INPUT_MAPPING.BUTTON, "back");
            __set_mapping(gp_start,   9, __INPUT_MAPPING.BUTTON, "start");

            __set_mapping(gp_guide, 8, __INPUT_MAPPING.BUTTON, "guide");
            
            return;
        break;
    
        #endregion


        #region Nintendo Switch Controllers

        case "CommunityLikeSwitch":
            if ((_vendor_and_product == "00000000") && __INPUT_ON_WINDOWS)
            {
                if (!__INPUT_SILENT) __input_trace("Setting PowerA Switch controller mapping");

                __set_face_button_mapping();
                __set_dpad_and_thumbstick_mapping();
                
                __set_mapping(gp_shoulderl,  4, __INPUT_MAPPING.BUTTON, "leftshoulder");
                __set_mapping(gp_shoulderr,  5, __INPUT_MAPPING.BUTTON, "rightshoulder");
                __set_mapping(gp_shoulderlb, 6, __INPUT_MAPPING.BUTTON, "lefttrigger");
                __set_mapping(gp_shoulderrb, 7, __INPUT_MAPPING.BUTTON, "righttrigger");

                __set_mapping(gp_select,  8, __INPUT_MAPPING.BUTTON, "back");
                __set_mapping(gp_start,   9, __INPUT_MAPPING.BUTTON, "start");
                __set_mapping(gp_guide,  12, __INPUT_MAPPING.BUTTON, "guide");
                __set_mapping(gp_misc1,  13, __INPUT_MAPPING.BUTTON, "misc1");

                __set_mapping(gp_stickl, 10, __INPUT_MAPPING.BUTTON, "leftstick");
                __set_mapping(gp_stickr, 11, __INPUT_MAPPING.BUTTON, "rightstick");
                
                return;
            }
            
        //Switch also uses Joy-Con Pair case   
        case "SwitchJoyConPair":
            if (__INPUT_ON_IOS)
            {
                __set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
                __set_mapping(gp_face2, 0, __INPUT_MAPPING.BUTTON, "b");      
                __set_mapping(gp_face3, 3, __INPUT_MAPPING.BUTTON, "x");
                __set_mapping(gp_face4, 2, __INPUT_MAPPING.BUTTON, "y");
                
                __set_mapping(gp_shoulderl,   4, __INPUT_MAPPING.BUTTON, "leftshoulder");
                __set_mapping(gp_shoulderr,   5, __INPUT_MAPPING.BUTTON, "rightshoulder");
                __set_mapping(gp_shoulderlb, 21, __INPUT_MAPPING.BUTTON, "lefttrigger");
                __set_mapping(gp_shoulderrb, 22, __INPUT_MAPPING.BUTTON, "righttrigger");
                
                __set_mapping(gp_select, 25, __INPUT_MAPPING.BUTTON, "back");
                __set_mapping(gp_start,   6, __INPUT_MAPPING.BUTTON, "start");
                
                __set_mapping(gp_stickl, 24, __INPUT_MAPPING.BUTTON, "leftstick");
                __set_mapping(gp_stickr, 23, __INPUT_MAPPING.BUTTON, "rightstick");
                
                __set_mapping(gp_padu,  7, __INPUT_MAPPING.BUTTON, "dpup");
                __set_mapping(gp_padd,  8, __INPUT_MAPPING.BUTTON, "dpdown");
                __set_mapping(gp_padl,  9, __INPUT_MAPPING.BUTTON, "dpleft");
                __set_mapping(gp_padr, 10, __INPUT_MAPPING.BUTTON, "dpright");
                
                __set_thumbstick_axis_mapping();
                
                return;
            }
        break;

        case "SwitchJoyConLeft":
        case "SwitchJoyConRight":
            if (__INPUT_ON_IOS)
            {
                __set_mapping(gp_face1, 0, __INPUT_MAPPING.BUTTON, "a");
                __set_mapping(gp_face2, 2, __INPUT_MAPPING.BUTTON, "b");      
                __set_mapping(gp_face3, 1, __INPUT_MAPPING.BUTTON, "x");
                __set_mapping(gp_face4, 3, __INPUT_MAPPING.BUTTON, "y");
                
                __set_mapping(gp_shoulderl, 4, __INPUT_MAPPING.BUTTON, "leftshoulder");
                __set_mapping(gp_shoulderr, 5, __INPUT_MAPPING.BUTTON, "rightshoulder");
                
                __set_mapping(gp_select, 6, __INPUT_MAPPING.BUTTON, "back");
                __set_mapping(gp_start, 0, undefined, "start");
                
                var _mapping = __set_mapping(gp_axislh, undefined, __INPUT_MAPPING.BUTTON_TO_AXIS, "leftx");
                _mapping.__raw_negative = 9;
                _mapping.__raw_positive = 10;
                
                _mapping = __set_mapping(gp_axislv, undefined, __INPUT_MAPPING.BUTTON_TO_AXIS, "lefty");
                _mapping.__raw_negative = 7;
                _mapping.__raw_positive = 8;

                return;
            }
        break;
    
        #endregion
    }
    
    #endregion
    
    #region Platform overrides
    
    switch(os_type)
    {
        
        #region Windows Xbox One Wireless BT (New firmware)
    
        case os_windows:
            if ((_vendor_and_product == "5e04e002")                                 //XbOne Wireless Revision 1
            ||  (_vendor_and_product == "5e04fd02")                                 //XbOne Wireless Revision 2
            &&  (gamepad_axis_value(__index, 1) == gamepad_axis_value(__index, 2))  //Axes 1 and 2 are the same
            &&  (gamepad_axis_value(__index, 4) == gamepad_axis_value(__index, 5))  //Axes 4 and 5 are the same
            &&  (__button_count == 17))                                             //Firmware per button count
            {
                if (!__INPUT_SILENT) __input_trace("Setting Xbox One Wireless controller to alternate mapping. Trigger data unavailable.");
        
                __set_mapping(gp_face1, 0, __INPUT_MAPPING.BUTTON, "a");
                __set_mapping(gp_face2, 1, __INPUT_MAPPING.BUTTON, "b");
                __set_mapping(gp_face3, 3, __INPUT_MAPPING.BUTTON, "x");
                __set_mapping(gp_face4, 4, __INPUT_MAPPING.BUTTON, "y");
    
                __set_mapping(gp_shoulderl, 6, __INPUT_MAPPING.BUTTON, "leftshoulder");
                __set_mapping(gp_shoulderr, 7, __INPUT_MAPPING.BUTTON, "rightshoulder");
    
                __set_mapping(gp_select, 15, __INPUT_MAPPING.BUTTON, "back");
                __set_mapping(gp_start,  11, __INPUT_MAPPING.BUTTON, "start");
    
                __set_mapping(gp_stickl, 13, __INPUT_MAPPING.BUTTON, "leftstick");
                __set_mapping(gp_stickr, 14, __INPUT_MAPPING.BUTTON, "rightstick");
    
                __set_thumbstick_axis_mapping(true);
                __set_mapping(gp_axisrh, 3, __INPUT_MAPPING.AXIS, "rightx");
                __set_mapping(gp_axisrv, 4, __INPUT_MAPPING.AXIS, "righty");
        
                __set_dpad_hat_mapping();
    
                //No trigger data :-(
                __set_mapping(gp_shoulderlb, 0, undefined, "lefttrigger");
                __set_mapping(gp_shoulderrb, 0, undefined, "righttrigger");
    
                __set_mapping(gp_guide, 16, __INPUT_MAPPING.BUTTON, "guide");
        
                return;
            }
        break;
    
        #endregion

    
        #region Missing mapping on MacOS
        
        case os_macosx:
            if ((__mapping == "no mapping") && (__button_count == 22) && (__axis_count ==  6) && (__hat_count == 0))
            {
                if (!__INPUT_SILENT) __input_trace("Overriding from \"no mapping\" on Mac");
        
                __set_mapping(gp_face1, 17, __INPUT_MAPPING.BUTTON, "a");
                __set_mapping(gp_face2, 18, __INPUT_MAPPING.BUTTON, "b");
                __set_mapping(gp_face3, 20, __INPUT_MAPPING.BUTTON, "x");
                __set_mapping(gp_face4, 21, __INPUT_MAPPING.BUTTON, "y");
        
                __set_mapping(gp_stickl, 4, __INPUT_MAPPING.BUTTON, "leftstick");
                __set_mapping(gp_stickr, 5, __INPUT_MAPPING.BUTTON, "rightstick");
        
                __set_mapping(gp_shoulderrb, 6, __INPUT_MAPPING.BUTTON, "righttrigger");
                __set_mapping(gp_shoulderlb, 7, __INPUT_MAPPING.BUTTON, "lefttrigger");
        
                __set_mapping(gp_select, 8, __INPUT_MAPPING.BUTTON, "back");
                __set_mapping(gp_start, 10, __INPUT_MAPPING.BUTTON, "start");

                __set_mapping(gp_shoulderl, 13, __INPUT_MAPPING.BUTTON, "leftshoulder");
                __set_mapping(gp_shoulderr, 14, __INPUT_MAPPING.BUTTON, "rightshoulder");
        
                __set_thumbstick_axis_mapping();    
        
                //No dpad data :-(
        
                __set_mapping(gp_guide, 11, __INPUT_MAPPING.BUTTON, "guide");
                __set_mapping(gp_misc1, 16, __INPUT_MAPPING.BUTTON, "misc1");

                return;
            }
        break;
    
        #endregion

    
        #region Linux overrides
    
        case os_linux:

            #region Steam Deck controller HID driver

            if (__guid == "03000000de2800000512000010010000")
            {
                //HID driver kicks in when running without Steam, some axes differ from the SDL mapping
                if (!__INPUT_SILENT) __input_trace("Overriding mapping for Steam Deck controller");
        
                //__set_mapping(???,    0, __INPUT_MAPPING.BUTTON,  ???);    //L pad press, no SDL key for this
                //__set_mapping(???,    1, __INPUT_MAPPING.BUTTON,  ???);    //R pad press, no SDL key for this
                __set_mapping(gp_misc1, 2, __INPUT_MAPPING.BUTTON, "misc1"); //… button

                __set_mapping(gp_face1, 3, __INPUT_MAPPING.BUTTON, "a");
                __set_mapping(gp_face2, 4, __INPUT_MAPPING.BUTTON, "b");
                __set_mapping(gp_face3, 5, __INPUT_MAPPING.BUTTON, "x");
                __set_mapping(gp_face4, 6, __INPUT_MAPPING.BUTTON, "y");
        
                __set_mapping(gp_shoulderl,   7, __INPUT_MAPPING.BUTTON, "leftshoulder");
                __set_mapping(gp_shoulderr,   8, __INPUT_MAPPING.BUTTON, "rightshoulder");
                __set_mapping(gp_shoulderlb,  9, __INPUT_MAPPING.BUTTON, "lefttrigger");
                __set_mapping(gp_shoulderrb, 10, __INPUT_MAPPING.BUTTON, "righttrigger");
        
                __set_mapping(gp_select, 11, __INPUT_MAPPING.BUTTON, "back");  //View button
                __set_mapping(gp_start,  12, __INPUT_MAPPING.BUTTON, "start"); //Menu button
                __set_mapping(gp_guide,  13, __INPUT_MAPPING.BUTTON, "guide"); //STEAM button
        
                __set_mapping(gp_stickl, 14, __INPUT_MAPPING.BUTTON, "leftstick");
                __set_mapping(gp_stickr, 15, __INPUT_MAPPING.BUTTON, "rightstick");
        
                __set_mapping(gp_padu, 16, __INPUT_MAPPING.BUTTON, "dpup");
                __set_mapping(gp_padd, 17, __INPUT_MAPPING.BUTTON, "dpdown");
                __set_mapping(gp_padl, 18, __INPUT_MAPPING.BUTTON, "dpleft");
                __set_mapping(gp_padr, 19, __INPUT_MAPPING.BUTTON, "dpright");
        
                __set_mapping(gp_paddle2, 20, __INPUT_MAPPING.BUTTON, "paddle2"); //L4 button
                __set_mapping(gp_paddle1, 21, __INPUT_MAPPING.BUTTON, "paddle1"); //R4 button
                __set_mapping(gp_paddle4, 22, __INPUT_MAPPING.BUTTON, "paddle4"); //L5 button
                __set_mapping(gp_paddle3, 23, __INPUT_MAPPING.BUTTON, "paddle3"); //R5 button
        
                __set_thumbstick_axis_mapping();
        
                return;        
            }

            #endregion

            #region Xbox driver catch-all

            if (__description == "Generic X-Box pad" || __description == "X360 Controller")
            {
                if (!__INPUT_SILENT) __input_trace("Overriding mapping for Xbox controller");
                
                __set_face_button_mapping();
                __set_dpad_hat_mapping();
            
                __set_mapping(gp_shoulderl, 4, __INPUT_MAPPING.BUTTON, "leftshoulder");
                __set_mapping(gp_shoulderr, 5, __INPUT_MAPPING.BUTTON, "rightshoulder");
            
                __set_mapping(gp_back,  6, __INPUT_MAPPING.BUTTON, "back");
                __set_mapping(gp_start, 7, __INPUT_MAPPING.BUTTON, "start");
                __set_mapping(gp_guide, 8, __INPUT_MAPPING.BUTTON, "guide");
            
                __set_mapping(gp_stickl,  9, __INPUT_MAPPING.BUTTON, "leftstick");
                __set_mapping(gp_stickr, 10, __INPUT_MAPPING.BUTTON, "rightstick");    
            
                __set_mapping(gp_shoulderlb, 2, __INPUT_MAPPING.AXIS, "lefttrigger");
                __set_mapping(gp_shoulderrb, 5, __INPUT_MAPPING.AXIS, "righttrigger");
            
                __set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx");
                __set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty");
            
                __set_mapping(gp_axisrh, 3, __INPUT_MAPPING.AXIS, "rightx");
                __set_mapping(gp_axisrv, 4, __INPUT_MAPPING.AXIS, "righty");                
            
                return;
            }

            #endregion

        break;
    
        #endregion
        
        
        #region Conflicting Android GUIDS

        case os_android:
            switch(__guid)
            {
                #region hid-nintendo
            
                case "4e696e74656e646f2053776974636820": //"Nintendo Switch "
                    if (__description == "Nintendo Switch Pro Controller")
                    {                       
                        __set_face_button_mapping();
                        __set_dpad_and_thumbstick_mapping();

                        __set_mapping(gp_shoulderl,   9, __INPUT_MAPPING.BUTTON, "leftshoulder");
                        __set_mapping(gp_shoulderr,  10, __INPUT_MAPPING.BUTTON, "rightshoulder");
                        __set_mapping(gp_shoulderlb, 17, __INPUT_MAPPING.BUTTON, "lefttrigger");
                        __set_mapping(gp_shoulderrb, 18, __INPUT_MAPPING.BUTTON, "righttrigger");

                        __set_mapping(gp_stickl, 7, __INPUT_MAPPING.BUTTON, "leftstick");
                        __set_mapping(gp_stickr, 8, __INPUT_MAPPING.BUTTON, "rightstick");

                        __set_mapping(gp_select, 14, __INPUT_MAPPING.BUTTON, "back");
                        __set_mapping(gp_start,   6, __INPUT_MAPPING.BUTTON, "start");                    
                        __set_mapping(gp_misc1,   5, __INPUT_MAPPING.BUTTON, "misc1");

                        return;
                    }

                    if (__description == "Nintendo Switch Right Joy-Con")
                    {
                        __set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
                        __set_mapping(gp_face2, 2, __INPUT_MAPPING.BUTTON, "b");
                        __set_mapping(gp_face3, 0, __INPUT_MAPPING.BUTTON, "x");
                        __set_mapping(gp_face4, 3, __INPUT_MAPPING.BUTTON, "y");

                        __set_mapping(gp_shoulderl,  9, __INPUT_MAPPING.BUTTON, "leftshoulder");
                        __set_mapping(gp_shoulderr, 17, __INPUT_MAPPING.BUTTON, "rightshoulder");

                        __set_mapping(gp_select, 5, __INPUT_MAPPING.BUTTON, "back");
                        __set_mapping(gp_start,  6, __INPUT_MAPPING.BUTTON, "start");

                        __set_mapping(gp_stickl, 8, __INPUT_MAPPING.BUTTON, "leftstick");

                        __set_mapping(gp_axislv, 0, __INPUT_MAPPING.AXIS, "lefty");
                    
                        var _mapping = __set_mapping(gp_axislh, 1, __INPUT_MAPPING.AXIS, "leftx");
                        _mapping.__reverse = true;

                        return;
                    }
                break;
            
                #endregion
        
            
                #region Mayflash Wii Adapters
            
                case "484a5a204d6179666c61736820576969": //"HJZ Mayflash Wii"
                    if (__description == "HJZ Mayflash WiiU Pro Game Controller Adapter")
                    {
                        if (!__INPUT_SILENT) __input_trace("Setting WiiU Pro Adapter mapping");

                        __set_mapping(gp_face3, 21, __INPUT_MAPPING.BUTTON, "x");
                        __set_mapping(gp_face1, 22, __INPUT_MAPPING.BUTTON, "a");
                        __set_mapping(gp_face2, 23, __INPUT_MAPPING.BUTTON, "b");
                        __set_mapping(gp_face4, 24, __INPUT_MAPPING.BUTTON, "y");

                        __set_mapping(gp_shoulderl,  25, __INPUT_MAPPING.BUTTON, "leftshoulder");
                        __set_mapping(gp_shoulderr,  26, __INPUT_MAPPING.BUTTON, "rightshoulder");
                        __set_mapping(gp_shoulderlb, 27, __INPUT_MAPPING.BUTTON, "lefttrigger");
                        __set_mapping(gp_shoulderrb, 28, __INPUT_MAPPING.BUTTON, "righttrigger");

                        __set_mapping(gp_select, 29, __INPUT_MAPPING.BUTTON, "back");
                        __set_mapping(gp_start,  30, __INPUT_MAPPING.BUTTON, "start");

                        __set_mapping(gp_stickl, 31, __INPUT_MAPPING.BUTTON, "leftstick");
                        __set_mapping(gp_stickr,  0, __INPUT_MAPPING.BUTTON, "rightstick");
                
                        __set_dpad_and_thumbstick_mapping();
            
                        return;
                    }
            
                    if (__description == "HJZ Mayflash Wiimote PC Adapter")
                    {
                        if (!__INPUT_SILENT) __input_trace("Setting DolphinBar mapping");

                        __set_mapping(gp_face3, 21, __INPUT_MAPPING.BUTTON, "x");
                        __set_mapping(gp_face4, 22, __INPUT_MAPPING.BUTTON, "y");
                        __set_mapping(gp_face1, 23, __INPUT_MAPPING.BUTTON, "a");
                        __set_mapping(gp_face2, 24, __INPUT_MAPPING.BUTTON, "b");

                        __set_mapping(gp_shoulderl,  25, __INPUT_MAPPING.BUTTON, "leftshoulder");
                        __set_mapping(gp_shoulderr,  26, __INPUT_MAPPING.BUTTON, "rightshoulder");
                        __set_mapping(gp_shoulderlb, 27, __INPUT_MAPPING.BUTTON, "lefttrigger");
                        __set_mapping(gp_shoulderrb, 28, __INPUT_MAPPING.BUTTON, "righttrigger");

                        __set_mapping(gp_select, 29, __INPUT_MAPPING.BUTTON, "back");
                        __set_mapping(gp_start,  30, __INPUT_MAPPING.BUTTON, "start");

                        __set_dpad_and_thumbstick_mapping();

                        __set_mapping(gp_guide, 0, __INPUT_MAPPING.BUTTON, "guide");
                
                        return;
                    }
                break;
            
                #endregion
            

                #region Retroid Pocket virtual gamepads
            
                case "64633735616665613536653363336132":
                    if (__description == "Retroid Pocket Controller")
                    {
                        if (!__INPUT_SILENT) __input_trace("Setting Retroid Pocket \"Retro mode\" mapping");

                        __set_mapping(gp_face2, 0, __INPUT_MAPPING.BUTTON, "b");
                        __set_mapping(gp_face1, 1, __INPUT_MAPPING.BUTTON, "a");
                        __set_mapping(gp_face4, 2, __INPUT_MAPPING.BUTTON, "y");
                        __set_mapping(gp_face3, 3, __INPUT_MAPPING.BUTTON, "x");
                    }
                    else
                    {
                        if (!__INPUT_SILENT) __input_trace("Setting Retroid Pocket \"Xbox mode\" mapping");                        
                        __set_face_button_mapping();
                    }

                    __set_mapping(gp_start,      6, __INPUT_MAPPING.BUTTON, "start");
                    __set_mapping(gp_stickl,     7, __INPUT_MAPPING.BUTTON, "leftstick");
                    __set_mapping(gp_stickr,     8, __INPUT_MAPPING.BUTTON, "rightstick");
                    __set_mapping(gp_shoulderl,  9, __INPUT_MAPPING.BUTTON, "leftshoulder");
                    __set_mapping(gp_shoulderr, 10, __INPUT_MAPPING.BUTTON, "rightshoulder");
                    __set_mapping(gp_select,    15, __INPUT_MAPPING.BUTTON, "back");

                    __set_dpad_and_thumbstick_mapping();
                
                    var _mapping = __set_mapping(gp_shoulderlb, 4, __INPUT_MAPPING.AXIS,  "lefttrigger");
                    _mapping.__extended_range = true;

                    _mapping = __set_mapping(gp_shoulderrb, 5, __INPUT_MAPPING.AXIS, "righttrigger");
                    _mapping.__extended_range = true;
            
                    __set_mapping(gp_paddle1, 19, __INPUT_MAPPING.BUTTON, "paddle1");
                    __set_mapping(gp_paddle2, 20, __INPUT_MAPPING.BUTTON, "paddle2");

                    return;
                break;
            
                #endregion
            
            
                #region 8BitDo NeoGeo Gamepad
            
                case "4a4a0000000000006d61743300000000":
                case "4a4a0000000000000000000000000000":
                    if (!__INPUT_SILENT) __input_trace("Setting NeoGeo gamepad mapping");
                    
                    __set_face_button_mapping();
                    __set_dpad_hat_mapping();
                
                    __set_mapping(gp_shoulderl,  9, __INPUT_MAPPING.BUTTON, "leftshoulder");
                    __set_mapping(gp_shoulderr, 10, __INPUT_MAPPING.BUTTON, "rightshoulder");
                
                    __set_mapping(gp_select, 15, __INPUT_MAPPING.BUTTON, "back");
                    __set_mapping(gp_start,   6, __INPUT_MAPPING.BUTTON, "start");
                
                    return;
                break;
            
                #endregion
            }
        break;
        
        #endregion
    }

    #endregion
    
    #region Remapping on SDL2 supported platforms
    
    if (__INPUT_SDL2_SUPPORT && INPUT_SDL2_REMAPPING)
    {
        if (is_array(__sdl2_definition))
        {            
            var _i = 2;
            repeat(array_length(__sdl2_definition) - 2)
            {
                var _entry = __sdl2_definition[_i];
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
                var _gm_constant = _global.__sdl2_look_up_table[$ _entry_name];
                if (_gm_constant == undefined)
                {
                    if (_entry_name != "platform")
                    {
                        if (!__INPUT_SILENT) __input_trace("Warning! Entry name \"", _entry_name, "\" not recognised (full string was \"", _entry, "\")");
                    }
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
                                if (!__INPUT_SILENT) __input_trace("Warning! Mapping entry could not be parsed (full string was \"", _entry, "\")");
                            break;
                        }
                    }
                    until(_raw_type != undefined);
                
                    //Determine which input index to scan for
                    //We floor this to cope with hats have decimal parts for their mask
                    var _input_slot = floor(real(_entry_1));
                
                    //Try to find out if this constant has been set already
                    var _mapping = __mapping_gm_to_raw[$ _gm_constant];
                    if (_raw_type == __INPUT_MAPPING.HAT_TO_AXIS)
                    {
                        if (_mapping == undefined)
                        {
                            _mapping = __set_mapping(_gm_constant, undefined, _raw_type, _entry_name);
                        }
                    
                        if (_output_negative)
                        {
                            _mapping.__raw_negative = _input_slot;
                        }
                        else if (_output_positive)
                        {
                            _mapping.__raw_positive = _input_slot;
                        }
                    }
                    else if (_raw_type == __INPUT_MAPPING.SPLIT_AXIS)
                    {
                        if (_mapping == undefined)
                        {
                            _mapping = __set_mapping(_gm_constant, undefined, _raw_type, _entry_name);
                        }
                    
                        if (_output_negative)
                        {
                            _mapping.__raw_negative = _input_slot;
                            if (_input_negative) _mapping.__negative_clamp_negative = true;
                            if (_input_positive) _mapping.__negative_clamp_positive = true;
                        }
                        else if (_output_positive)
                        {
                            _mapping.__raw_positive = _input_slot;
                            if (_input_negative) _mapping.__positive_clamp_negative = true;
                            if (_input_positive) _mapping.__positive_clamp_positive = true;
                        }
                    }
                    else if (_raw_type == __INPUT_MAPPING.BUTTON_TO_AXIS)
                    {
                        if (_mapping == undefined)
                        {
                            _mapping = __set_mapping(_gm_constant, undefined, _raw_type, _entry_name);
                        }
                    
                        if (_output_negative)
                        {
                            _mapping.__raw_negative = _input_slot;
                        }
                        else if (_output_positive)
                        {
                            _mapping.__raw_positive = _input_slot;
                        }
                    }
                    else
                    {
                        if (_mapping == undefined)
                        {
                            _mapping = __set_mapping(_gm_constant, _input_slot, _raw_type, _entry_name);
                        }
                        else
                        {
                            if (!__INPUT_SILENT) __input_trace("Warning! Mapping for \"", _entry, "\" is a redefinition of entry name \"", _entry_name, "\"");
                        }
                    
                        //If necessary, apply modifiers to the mapping input
                        if (_input_invert  ) _mapping.__invert         = true;
                        if (_input_reverse ) _mapping.__reverse        = true;
                        if (_input_negative) _mapping.__clamp_negative = true;
                        if (_input_positive) _mapping.__clamp_positive = true;
                    }
                
                    //Now manage the hat masks, including setting up hat-on-axis masks
                    if ((_raw_type == __INPUT_MAPPING.HAT) || (_raw_type == __INPUT_MAPPING.HAT_TO_AXIS))
                    {
                        var _hat_mask = floor(10 * abs((real(_entry_1) mod 1)));
                        if (_raw_type == __INPUT_MAPPING.HAT)
                        {
                            _mapping.__hat_mask = _hat_mask;
                        }
                        else if (_raw_type == __INPUT_MAPPING.HAT_TO_AXIS)
                        {
                            if (_output_negative)
                            {
                                _mapping.__hat_mask_negative = _hat_mask;
                            }
                            else if (_output_positive)
                            {
                                _mapping.__hat_mask_positive = _hat_mask;
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
                        if (__INPUT_ON_LINUX && _is_directional)
                        {    
                            if (__INPUT_DEBUG) __input_trace("  (Limited axis range)");
                            _mapping.__limited_range = true;
                        }
                        else if (!__INPUT_ON_LINUX && !_is_directional && (gamepad_axis_count(__index) >= _input_slot))
                        {
                            //Nondirectional axes (triggers) use full axis range (excepting Linux remappings and XInput)
                            if (__INPUT_DEBUG) __input_trace("  (Extended axis range)");
                            _mapping.__extended_range = true;
                        }
                    }
                }
            
                ++_i;
            }
            
            //Reset Android keymapped dpad if necessary
            if (__INPUT_ON_ANDROID && (__hat_count > 0) && (_vendor_and_product == ""))
            {
                var _mapping = undefined;
                var _dpad_array = [gp_padu, gp_padd, gp_padl, gp_padr];
                
                var _matched = 0;
                repeat(array_length(_dpad_array))
                {
                    //Check mapping match (b11 - b14)
                    _mapping = __mapping_gm_to_raw[$ _dpad_array[_matched]];
                    if (!is_struct(_mapping) || (_mapping[$ "__raw"] != 11 + _matched)) break;
                    ++_matched;
                }
            
                if (_matched == 4)
                {
                    //Dpad mapping matches Android keymap, switch to hat
                    if (__INPUT_DEBUG) __input_trace("  (Remapping dpad buttons to hat)");
                    __set_dpad_hat_mapping();
                }
            }
        
            ////Add Atari VCS Classic twist mapping (semantically incorrect)
            //if ((__raw_type == "CommunityVCSClassic") || (__raw_type == "HIDAtariVCSClassic"))
            //{
            //    var _mapping = __set_mapping(gp_axisrh, 0, __INPUT_MAPPING.AXIS, "rightx");
            //    _mapping.__limited_range = __INPUT_ON_LINUX;
            //}
            
            //Change Ouya guide mapping
            if ((__raw_type == "CommunityOuya") && (__INPUT_ON_WINDOWS || __INPUT_ON_LINUX))
            {
                //Guide button issues 2 reports: one a tick after release which is usually too fast for GM's
                //interupt to catch, and another that's for long press that works after being held 1 second.
                //SDL's map assigns the first but we switch to the second which will work reliably for GM.
                if (__INPUT_DEBUG) __input_trace("  (Remapping guide button)");
                __set_mapping(gp_guide, 15, __INPUT_MAPPING.BUTTON, "guide");
            }
        
            //Swap P2 and P3 mappings on Elite controller only
            if ((__simple_type == "xbox one") && __input_string_contains(__description, "Elite") 
            &&  is_struct(__mapping_gm_to_raw[$ string(gp_paddle2)]) && is_struct(__mapping_gm_to_raw[$ string(gp_paddle3)]))
            {
                if (__INPUT_DEBUG) __input_trace("  (Swapping Elite P2 and P3)");
                var _p2_mapping = __mapping_gm_to_raw[$ string(gp_paddle2)].__raw;
                __set_mapping(gp_paddle2, __mapping_gm_to_raw[$ string(gp_paddle3)].__raw, __INPUT_MAPPING.BUTTON, "paddle2");
                __set_mapping(gp_paddle3, _p2_mapping, __INPUT_MAPPING.BUTTON, "paddle3");
            }
            
            return;
        }
        else
        {
            if (!__INPUT_SILENT) __input_trace("No SDL2 remapping available, falling back to GameMaker's mapping (", __mapping, ")");
        }
    }    
    
    #endregion
    
    #region Generic mapping    
        
    __set_mapping(gp_face1, gp_face1, __INPUT_MAPPING.BUTTON, "a", false);
    __set_mapping(gp_face2, gp_face2, __INPUT_MAPPING.BUTTON, "b", false);
    __set_mapping(gp_face3, gp_face3, __INPUT_MAPPING.BUTTON, "x", false);
    __set_mapping(gp_face4, gp_face4, __INPUT_MAPPING.BUTTON, "y", false);
    
    __set_mapping(gp_shoulderl, gp_shoulderl, __INPUT_MAPPING.BUTTON, "leftshoulder",  false);
    __set_mapping(gp_shoulderr, gp_shoulderr, __INPUT_MAPPING.BUTTON, "rightshoulder", false);
    
    __set_mapping(gp_start, gp_start, __INPUT_MAPPING.BUTTON, "start",   false);
    
    __set_mapping(gp_padu,  gp_padu,  __INPUT_MAPPING.BUTTON, "dpup",    false);
    __set_mapping(gp_padd,  gp_padd,  __INPUT_MAPPING.BUTTON, "dpdown",  false);
    __set_mapping(gp_padl,  gp_padl,  __INPUT_MAPPING.BUTTON, "dpleft",  false);
    __set_mapping(gp_padr,  gp_padr,  __INPUT_MAPPING.BUTTON, "dpright", false);        
        
    __set_mapping(gp_axislh, gp_axislh, __INPUT_MAPPING.AXIS,   "leftx",      false);
    __set_mapping(gp_axislv, gp_axislv, __INPUT_MAPPING.AXIS,   "lefty",      false);
    __set_mapping(gp_stickl, gp_stickl, __INPUT_MAPPING.BUTTON, "leftstick",  false);
    
    __set_mapping(gp_axisrh, gp_axisrh, __INPUT_MAPPING.AXIS,   "rightx",     false);
    __set_mapping(gp_axisrv, gp_axisrv, __INPUT_MAPPING.AXIS,   "righty",     false);
    __set_mapping(gp_stickr, gp_stickr, __INPUT_MAPPING.BUTTON, "rightstick", false);
        
    //PlayStation only
    if (__INPUT_ON_PS)
    {
        __set_mapping(gp_shoulderlb, 4, __INPUT_MAPPING.AXIS, "lefttrigger" );
        __set_mapping(gp_shoulderrb, 5, __INPUT_MAPPING.AXIS, "righttrigger");
        
        __set_mapping(gp_select, gp_select, __INPUT_MAPPING.BUTTON, "touchpad");
            
        return;
    }
        
    __set_mapping(gp_shoulderlb, gp_shoulderlb, __INPUT_MAPPING.AXIS,   "lefttrigger",  false);
    __set_mapping(gp_shoulderrb, gp_shoulderrb, __INPUT_MAPPING.AXIS,   "righttrigger", false);
    __set_mapping(gp_select,     gp_select,     __INPUT_MAPPING.BUTTON, "back",         false);
    
    return;
    
    #endregion
}
