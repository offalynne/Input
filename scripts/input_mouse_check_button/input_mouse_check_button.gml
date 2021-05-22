/// @param binding

function input_mouse_check_button(_binding)
{
	//Extended mouse button handling on Windows
    if (os_type == os_windows)
	{
		switch (_binding)
		{
			//TODO - Case none/any/left to support touchpad & touchscreen tap
			case mb_back:
			case mb_forward:	
				return keyboard_check_direct(_binding);
				break;
			default:
				return device_mouse_check_button(0, _binding);
				break;
		}
	}
	
	//Off-Windows mouse button handling
	if (_binding < mb_back) 
		return device_mouse_check_button(0, _binding);
		
	return false;
}