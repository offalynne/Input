// Feather disable all

/// Transforms values stored in a gamepad struct using known quirks. This includes
/// comprehensive blocking and type overriding during the transformation.
/// 
/// This function is called from `__InputGamepadDiscover()`, please see that function
/// for more context. This function will only operate on SDL supported platforms
/// 
/// @param gamepadStruct

function __InputGamepadTransformQuirks(_gamepadStruct)
{    
    //Gamepad quirks
    with(_gamepadStruct)
    {
        var _description = string_lower(__description);
        var _buttonCount = gamepad_button_count(__gamepadIndex);
        var _axisCount   = gamepad_axis_count(__gamepadIndex);
        var _hatCount    = gamepad_hat_count(__gamepadIndex);
        var _vidPid      = __vendor + __product;
        
        switch (os_type)
        {
            case os_windows:                
                if ((_vidPid == "63257505") && (_buttonCount == 13) && (_hatCount == 1) && (__InputStringContains(_description, "switch co.,ltd. retro-bit controller"))) 
                {
                    __InputTrace("Overriding gamepad type: Switch (Saturn Wireless Pro");
                    __type = INPUT_GAMEPAD_TYPE_SWITCH;
                }
                else if ((_vidPid == "7e050920") && (_buttonCount > 21) && !((_buttonCount == 30) && (_hatCount == 0)))
                {
                    __InputTrace("Blocking gamepad: Switch USB Controller");
                    __blocked = true;
                }
                else if ((_vidPid = "4c056802") && (_buttonCount == 19) && (_axisCount == 4)) 
                {
                    __InputTrace("Blocking gamepad: PS3 Controller (bad driver)");
                    __blocked = true;
                }
                else if ((_vidPid == "4c056802") && (_buttonCount == 0) && (_axisCount == 8))
                {
                    __InputTrace("Blocking gamepad: DSHidMini Gyro");
                    __blocked = true;
                }
                else if (_vidPid == "31730100")
                {
                    __InputTrace("Blocking gamepad: DSHIDMini DS4W mode");
                    __blocked = true;
                }
            break;

            case os_macosx:
                if ((__InputStringMatches(__guid, "03000000050b00000619000000010000", "03000000050b0000e318000000010000", "03000000050b0000e518000000010000", "03000000050b00005819000000010000", "03000000050b0000181a000000010000", "03000000050b00001a1a000000010000", "03000000050b00001c1a000000010000"))) 
                {
                    __InputTrace("Blocking gamepad: ROG Mouse");
                    __blocked = true;
                }
            break;

            case os_linux:                
                if ((_buttonCount == 144) && (_axisCount == 0)) 
                {
                    __InputTrace("Blocking gamepad: Steam Deck virtual keyboard");
                    __blocked = true;
                }
                else if ((_buttonCount == 0) && (_axisCount == 6) && (_hatCount == 0)) 
                {
                    __InputTrace("Blocking gamepad: Joy-Con IMU");
                    __blocked = true;
                }
                else if ((_vidPid == "63257505") && (_buttonCount == 13) && (_hatCount == 1) && (__InputStringContains(_description, "usb"))) 
                {
                    __InputTrace("Overriding gamepad type: Saturn Wireless Pro");
                    __type = INPUT_GAMEPAD_TYPE_SWITCH;
                }
                else if ((__InputStringContains(_description, "touchpad", "touchscreen"))) 
                {           
                    __InputTrace("Blocking gamepad: Touchpad");
                    __blocked = true;
                }
                else if ((__InputStringMatches(__guid, "03000000050b00000619000011010000", "03000000050b0000e318000011010000", "03000000050b0000e518000011010000", "03000000050b00005819000011010000", "03000000050b0000181a000011010000", "03000000050b00001a1a000011010000", "03000000050b00001c1a000011010000"))) 
                {
                    __InputTrace("Blocking gamepad: ROG Mouse");
                    __blocked = true;
                }
                else if (__InputStringMatches(__vendor, "4e04", "8eb5", "3328", "ef0e", "f304", "e704", "d21f", "0804", "5704", "3004", "cb06", "da09", "3105", "6a05", "ef17", "1c1b"))
                {
                    //VID Blocklist sourced from https://github.com/chromium/chromium/blob/main/device/gamepad/gamepad_blocklist.cc
                    __InputTrace("Blocking gamepad: Blocklisted vendor ID");
                    __blocked = true;                    
                    
                }
                else if (__InputStringMatches(_vidPid, "5e049d00", "5e04b000", "5e04b400", "5e043007", "5e044507", "5e044807", "5e045007", "5e046807", "5e047307", "5e04a507", "5e04b207", "5e040008", "6b0410ff", "6d040ac3", "d9040980", "d904dfa0", "450c0a80", "17100320", "c016d004", "571d03ad", "7d1ecb2d", "7d1e4a2e", "a0202d42", "16251f00", "16252800", "ce26a201", "ac053232", "eb0301ff", "eb0302ff", "12042171", "3c1b3c1b", "b404f3fe", "620d1a9a", "d9040880", "d90492a2", "5e04cd07", "5e042209", "5e04c009"))
                {
                    //VID+PID Blocklist sourced from https://github.com/denilsonsa/udev-joystick-blacklist
                    __InputTrace("Blocking gamepad: Blocklisted device ID");
                    __blocked = true;                    
                }
            break;
            
            case os_android:                
                if (_description == "joy-con charging grip")
                {
                    __InputTrace("Blocking gamepad: Switch charging grip");
                    __blocked = true;
                }
                else if (__guid == "39666538356630396233636633333330") 
                {
                    __InputTrace("Blocking gamepad: Xbox Elite Series 2");
                    __blocked = true;
                }
                else if ((__InputStringMatches(__guid, "4e696e74656e646f20436f2e2c204c74", "61393962646434393836356631636132", "31343431323332663936386663646631", "65366131663736363061313736656431", "31613237643563656561633964393335", "39373064396565646338333134303131"))) 
                {
                    __InputTrace("Blocking gamepad: Switch USB Controller");
                    __blocked = true;

                }
                else if ((__InputStringMatches(__guid, "37306138633665393031353462623835", "30653530626463313864336165306236", "38346462303632636161363531303766", "66626636666361303930383433646337"))) 
                {
                    __InputTrace("Blocking gamepad: TV Remote");
                    __blocked = true;
                }
            break;
        }
    }
}
