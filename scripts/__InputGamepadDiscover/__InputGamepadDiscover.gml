// Feather disable all

/// @param gamepadStruct

function __InputGamepadDiscover(_gamepadStruct)
{
    static _system           = __InputSystem();
    static _typeLookupStruct = __InputCreateTypeLookup();
    
    with(_gamepadStruct)
    {
        var _device = __gamepadIndex;
        
        __InputTrace("Discovering gamepad ", _device, ", desc=\"", gamepad_get_description(_device), "\", GUID=\"", gamepad_get_guid(_device), "\", buttons = ", gamepad_button_count(_device), ", axes = ", gamepad_axis_count(_device), ", hats = ", gamepad_hat_count(_device));
        
        __guid         = gamepad_get_guid(_device);
        __description  = gamepad_get_description(_device);
        __type         = INPUT_GAMEPAD_TYPE_UNKNOWN;
        
        if (INPUT_ON_SWITCH)
        {
            __type = __InputGamepadIdentifySwitchType(_device, __description);
            
            //Going full custom
            InputPlugInGamepadNullifyAllMappings(_device);
            
            InputPlugInGamepadResetMapping(_device, gp_start);
            
            InputPlugInGamepadResetMapping(_device, gp_stickl);
            InputPlugInGamepadResetMapping(_device, gp_axislh);
            InputPlugInGamepadResetMapping(_device, gp_axislv);
            
            InputPlugInGamepadResetMapping(_device, gp_face1);
            InputPlugInGamepadResetMapping(_device, gp_face2);
            InputPlugInGamepadResetMapping(_device, gp_face3);
            InputPlugInGamepadResetMapping(_device, gp_face4);
            
            if (__type == INPUT_GAMEPAD_TYPE_SWITCH)
            {
                //Right stick only available when there're actually two thumbsticks :')
                InputPlugInGamepadResetMapping(_device, gp_stickr);
                InputPlugInGamepadResetMapping(_device, gp_axisrh);
                InputPlugInGamepadResetMapping(_device, gp_axisrv);
                
                //Permit dpad but only for handheld / dual Joy-Con / Pro Controller
                InputPlugInGamepadResetMapping(_device, gp_padu);
                InputPlugInGamepadResetMapping(_device, gp_padd);
                InputPlugInGamepadResetMapping(_device, gp_padl);
                InputPlugInGamepadResetMapping(_device, gp_padr);
                
                //Even in other gamepad modes Switch triggers are digital rather than analogue so we treat those as strict buttons
                InputPlugInGamepadResetMapping(_device, gp_shoulderl);
                InputPlugInGamepadResetMapping(_device, gp_shoulderr);
                InputPlugInGamepadResetMapping(_device, gp_shoulderlb);
                InputPlugInGamepadResetMapping(_device, gp_shoulderrb);
                
                //Only permit gp_select for handheld / dual Joy-Con / Pro Controller
                InputPlugInGamepadResetMapping(_device, gp_select);
            }
            else
            {
                if (__INPUT_SWITCH_JOYCON_HORIZONTAL_HOLDTYPE)
                {
                    //Single Joy-Cons in horizontal report L/R/ZL/ZR as shoulder buttons even though they rest in the player's palm. No idea why, but we disallow that
                    //Also it seems like GameMaker implements SL and SR weirdly so we circumvent that
                    if (__type == INPUT_GAMEPAD_TYPE_JOYCON_LEFT)
                    {
                        InputPlugInGamepadSetMapping(_device, gp_shoulderl, function(_device) { return gamepad_button_value(_device, 16); });
                        InputPlugInGamepadSetMapping(_device, gp_shoulderr, function(_device) { return gamepad_button_value(_device, 17); });
                    }
                    else
                    {
                        InputPlugInGamepadSetMapping(_device, gp_shoulderl, function(_device) { return gamepad_button_value(_device, 18); });
                        InputPlugInGamepadSetMapping(_device, gp_shoulderr, function(_device) { return gamepad_button_value(_device, 19); });
                    }
                }
                else
                {
                    //SL/SR are still technically active in vertical mode too but that's silly so we ignore them
                    if (__type == INPUT_GAMEPAD_TYPE_JOYCON_LEFT)
                    {
                        InputPlugInGamepadSetMapping(_device, gp_shoulderl, function(_device) { return gamepad_button_value(_device, 6); });
                        InputPlugInGamepadSetMapping(_device, gp_shoulderr, function(_device) { return gamepad_button_value(_device, 8); });
                    }
                    else
                    {
                        InputPlugInGamepadSetMapping(_device, gp_shoulderl, function(_device) { return gamepad_button_value(_device, 7); });
                        InputPlugInGamepadSetMapping(_device, gp_shoulderr, function(_device) { return gamepad_button_value(_device, 9); });
                    }
                }
            }
        }
        else if (INPUT_ON_PS4)
        {
            //Convert gp_select to gp_touchpadbutton
            InputPlugInGamepadNullifyMapping(_device, gp_select);
            InputPlugInGamepadSetMapping(_device, gp_touchpadbutton, function(_device) { return gamepad_button_value(_device, gp_select); });
            
            __type = INPUT_GAMEPAD_TYPE_PS4;
        }
        else if (INPUT_ON_PS5)
        {
            //Convert gp_select to gp_touchpadbutton
            InputPlugInGamepadNullifyMapping(_device, gp_select);
            InputPlugInGamepadSetMapping(_device, gp_touchpadbutton, function(_device) { return gamepad_button_value(_device, gp_select); });
            
            __type = INPUT_GAMEPAD_TYPE_PS5;
        }
        else if (INPUT_ON_XBOX)
        {
            __type = INPUT_GAMEPAD_TYPE_XBOX;
        }
        else //Not console
        {
            //Unpack the vendor/product IDs from the gamepad's GUID
            var _result = __InputGamepadGUIDParse(__guid);
            __vendor  = _result.__vendor;
            __product = _result.__product;
            
            __xinput = (INPUT_ON_WINDOWS && (_device < 4) && (not __InputStringContains(__guid, "000000007801"))); //"H" (HID)
            
            //Force type if it's an XInput device
            if (__xinput)
            {
                __description = "XInput";
                __type = INPUT_GAMEPAD_TYPE_XBOX;
            }
            else
            {
                __InputTrace("Identifying gamepad type using VID + PID \"", __vendor + __product, "\"");
                __type = _typeLookupStruct[$ __vendor + __product];
                
                if (__type == undefined)
                {
                    __InputTrace("Unsuccessful; identifying gamepad using description \"", __description, "\"");
                    __type = __InputGamepadIdentifyDescriptionType(__description);
                    
                    if (__type == undefined)
                    {
                        __InputTrace("Unsuccessful; using fallback type");
                        __type = INPUT_GAMEPAD_FALLBACK_TYPE;
                    }
                }
                
                __InputTrace("Gamepad type decided as ", __type);
            }
            
            //Read Steam Input values and modify our gamepad representation to match
            __InputGamepadTransformSteam(self);
            
            //Perform further transforms to handle nasty edge cases
            __InputGamepadTransformQuirks(self);
        }
    }
}