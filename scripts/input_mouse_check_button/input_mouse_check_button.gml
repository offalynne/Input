/// @param binding

function input_mouse_check_button(_binding)
{
	//Extended mouse button handling on Windows
    if (os_type == os_windows)
	{
		var _btn = device_mouse_check_button(0, _binding);
		
		switch (_binding)
		{
			case mb_back:
			case mb_forward:	
				return (window_has_focus() && keyboard_check_direct(_binding));
				break;
			case mb_none:
				return (_btn && !global.__input_tap_click);
				break;
			case mb_any:
			case mb_left:		
				return (_btn || global.__input_tap_click); 
				break;
			default:
				return _btn;
				break;
		}
	}
	
	//Off-Windows mouse button handling
	if (_binding < mb_back) 
		return device_mouse_check_button(0, _binding);
		
	return false;
}
