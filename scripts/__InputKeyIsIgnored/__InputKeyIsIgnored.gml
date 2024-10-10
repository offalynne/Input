// Feather disable all

/// @param keyCode

function __InputKeyIsIgnored(_keyCode)
{
    static _ignoreMap = (function()
    {
        var _ignoreMap = ds_map_create();
        
        _ignoreMap[? vk_alt  ] = true;
        _ignoreMap[? vk_ralt ] = true;
        _ignoreMap[? vk_lalt ] = true;
        _ignoreMap[? vk_lmeta] = true;
        _ignoreMap[? vk_rmeta] = true;
        
        _ignoreMap[?0xFF] = true; //Vendor key
        
        if (INPUT_ON_WINDOWS)
        {
            _ignoreMap[? 0xE6] = true; //OEM key (Power button on Steam Deck)
        }
        
        if (INPUT_ON_ANDROID)
        {
            _ignoreMap[? vk_backspace] = true; //Emmitted by hard and soft "Back" buttons, gamepad "B" button
        }
        
        if (INPUT_ON_MOBILE && INPUT_ON_APPLE)
        {
            _ignoreMap[? 0x7C] = true; //Screenshot
        }
        
        if (INPUT_ON_WEB)
        {
            if (INPUT_ON_APPLE)
            {
                _ignoreMap[? vk_f10] = true; //Fullscreen
                _ignoreMap[? vk_capslock] = true;
            }
            else
            {
                _ignoreMap[? vk_f11] = true; //Fullscreen
            }
        }
        
        _ignoreMap[? vk_numlock] = true;   //Num Lock
        _ignoreMap[? vk_scrollock] = true; //Scroll Lock
        
        if (INPUT_ON_WEB || INPUT_ON_WINDOWS)
        {
            _ignoreMap[? 0x15] = true; //IME Kana/Hanguel
            _ignoreMap[? 0x16] = true; //IME On
            _ignoreMap[? 0x17] = true; //IME Junja
            _ignoreMap[? 0x18] = true; //IME Final
            _ignoreMap[? 0x19] = true; //IME Kanji/Hanja
            _ignoreMap[? 0x1A] = true; //IME Off
            _ignoreMap[? 0x1C] = true; //IME Convert
            _ignoreMap[? 0x1D] = true; //IME Nonconvert
            _ignoreMap[? 0x1E] = true; //IME Accept
            _ignoreMap[? 0x1F] = true; //IME Mode Change
            _ignoreMap[? 0xE5] = true; //IME Process
            
            _ignoreMap[? 0xA6] = true; //Browser Back
            _ignoreMap[? 0xA7] = true; //Browser Forward
            _ignoreMap[? 0xA8] = true; //Browser Refresh
            _ignoreMap[? 0xA9] = true; //Browser Stop
            _ignoreMap[? 0xAA] = true; //Browser Search
            _ignoreMap[? 0xAB] = true; //Browser Favorites
            _ignoreMap[? 0xAC] = true; //Browser Start/Home
            
            _ignoreMap[? 0xAD] = true; //Volume Mute
            _ignoreMap[? 0xAE] = true; //Volume Down
            _ignoreMap[? 0xAF] = true; //Volume Up
            _ignoreMap[? 0xB0] = true; //Next Track
            _ignoreMap[? 0xB1] = true; //Previous Track
            _ignoreMap[? 0xB2] = true; //Stop Media
            _ignoreMap[? 0xB3] = true; //Play/Pause Media
            
            _ignoreMap[? 0xB4] = true; //Launch Mail
            _ignoreMap[? 0xB5] = true; //Launch Media
            _ignoreMap[? 0xB6] = true; //Launch App 1
            _ignoreMap[? 0xB7] = true; //Launch App 2
            
            _ignoreMap[? 0xFB] = true; //Zoom
        }
        
        return _ignoreMap;
    })();
    
    if (_keyCode == undefined) return true;
    if ((_keyCode < INPUT_KEYCODE_MIN) || (_keyCode > INPUT_KEYCODE_MAX)) return true;
    
    return ds_map_exists(_ignoreMap, _keyCode);
}