function __input_load_type_csv(_filename)
{
    var _t = get_timer();
    
    __input_trace("Loading controller type CSV from \"", _filename, "\"");
    
    var _buffer = buffer_load(_filename);
    var _string = buffer_read(_buffer, buffer_text);
    buffer_delete(_buffer);
    
    var _count = 0;
    var _row_array = __input_csv_to_array(_string, ",", "\"");
    
    var _y = 0;
    repeat(array_length(_row_array))
    {
        var _column_array = _row_array[_y];
        
        var _raw_type = _column_array[0];
        
        if (INPUT_SIMPLIFY_CONTROLLER_TYPES)
        {
            //Alias the raw type to an internal type
            var _type = _raw_type;
            switch(_raw_type)
            {
                case "SteamController":
                case "SteamControllerV2":
                    _type = "steam";
                break;
                
                case "CommunityLikeXBox":
                    _type = "xbox";
                break;
                
                case "XBox360Controller":
                case "CommunityXBox360":
                    _type = "xbox 360";
                break;
                
                case "XBoxOneController":
                case "CommunityXBoxOne":
                    _type = "xbox one";
                break;
                
                case "PS3Controller":
                case "CommunityPSX":
                    _type = "psx";
                break;
                
                case "PS4Controller":
                case "CommunityPS4":
                    _type = "ps4";
                break;
                
                case "PS5Controller":
                    _type = "ps5";
                break;
                
                case "AppleController":
                    _type = "apple";
                break;
                
                case "SwitchProController":
                    _type = "switch pro";
                break;
                
                case "SwitchJoyConLeft":
                    _type = "switch joycon left";
                break;
                
                case "SwitchJoyConRight":
                    _type = "switch joycon right";
                break;
                
                case "SwitchInputOnlyController":
                case "XInputSwitchController":
                case "CommunityLikeSwitch":
                    _type = "switch";
                break;
                
                case "MobileTouch":
                    _type = "mobile touch";
                break;
                
                case "CommunitySaturn":
                    _type = "saturn";
                break;
                
                case "CommunitySNES":
                    _type = "snes";
                break;
                
                case "Community8BitDo":
                    _type = "8bitdo";
                break;
                
                case "CommunityGameCube":
                    _type = "gamecube";
                break;
                
                case "CommunityOuya":
                    _type = "ouya";
                break;
                
                case "CommunityStadia":
                    _type = "stadia";
                break;
                
                case "UnknownNonSteamController":
                    _type = "unknown";
                break;
                
                default:
                    _type = "unknown";
                break;
            }
        }
        
        var _x = 1;
        repeat(array_length(_column_array) - 1)
        {
            var _tag = _column_array[_x];
            global.__input_type_dictionary[$ _tag] = _type;
            _count++;
            
            ++_x;
        }
        
        ++_y;
    }
    
    __input_trace(_count, " controller type definitions found");
    __input_trace("Loaded in ", (get_timer() - _t)/1000, "ms");
    
    return true;
}