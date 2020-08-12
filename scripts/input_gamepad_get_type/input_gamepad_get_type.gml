/// @param gamepadIndex

function input_gamepad_get_type(_index)
{
    var _gamepad = global.__input_gamepads[_index];
    if (!is_struct(_gamepad)) return undefined;
	
	with(_gamepad)
	{
		//If we have a cached value, return it
		if (type != undefined) return type;
		//Otherwise, we discover what kind of gamepad this is...
		
		//Unpack the vendor/product IDs from the gamepad's GUID
	    if (os_type == os_windows)
	    {
	        //Windows uses an older version of SDL
	        vendor  = string_copy(guid, 1, 4);
	        product = string_copy(guid, 5, 4);
	        xinput  = (index < 4);
	    }
	    else if ((os_type == os_macosx) || (os_type == os_linux))
	    {
	        vendor  = string_copy(guid,  9, 4);
	        product = string_copy(guid, 17, 4);
	        xinput  = (index < 4);
	    }
	    else if ((os_type == os_ios) || (os_type == os_android))
	    {
	        vendor  = string_copy(guid,  9, 4);
	        product = string_copy(guid, 17, 4);
	    }
	    else
	    {
	        vendor  = undefined;
	        product = undefined;
	    }
		
		//If we're on a specific OS, report the gamepad accordingly
		switch(os_type)
		{
			case os_switch:
				type = "Joy-Con";
				return type;
			break;
		
			case os_ps4:
				type = "DualShock 4";
				return type;
			break;
		
			case os_xboxone:
				type = "Xbox One";
				return type;
			break;
		}
	}
}