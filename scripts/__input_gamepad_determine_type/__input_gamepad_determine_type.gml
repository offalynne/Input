/// @param gamepadStruct

function __input_gamepad_determine_type(_gamepad)
{
    if (!is_struct(_gamepad)) return "unknown";
    
    with(_gamepad)
    {
        //If we're on a specific OS, set the gamepad type accordingly
        switch(os_type)
        {
            case os_switch:
                type = "switch";
                exit;
            break;
            
            case os_ps4:
                type = "ps4";
                exit;
            break;
            
            case os_xboxone:
                type = "xbone";
                exit;
            break;
        }
        
        if (xinput == true)
        {
            //We can't get the actual GUID for XInput controllers for some reason so we have to assume they're all the same :(
            type = "xb360";
        }
        else if (variable_struct_exists(global.__input_type_dictionary, vendor + product))
        {
            type = global.__input_type_dictionary[$ vendor + product];
        }
        else
        {
            type = "unknown";
        }
    }
}