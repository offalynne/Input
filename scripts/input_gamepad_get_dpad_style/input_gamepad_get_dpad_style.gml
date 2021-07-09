/// @param gamepadIndex

function input_gamepad_get_dpad_style(_index)
{
    switch(input_gamepad_get_type(_index))
    {
        case "unknown":
            return "unknown";
        break;
        
        case "steam":
        case "xbox 360":
        case "saturn":
        case "ouya":
            return "disc";
        break;
        
        case "psx":
        case "ps4":
        case "ps5":
            return "segments";
        break;
        
        case "switch":
        case "switch handheld": //Railed JoyCons or Switch Lite (Slot 0)
        case "switch pro":
            return "arrows";
        break;
        
        case "switch joycon left":
        case "switch joycon right":
            return "stick";
        break;

        case "switch joycon pair":
            return "buttons";
        break;
        
        default:
            return "cross";
        break;
    }
}
