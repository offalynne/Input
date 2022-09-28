/// @desc    Sets the source mode. The parameter for this function should be a member of the INPUT_SOURCE_MODE enum:
///              .FIXED
///              .JOIN
///              .HOTSWAP
///              .MIXED
///              .MULTIDEVICE
/// @param   mode

function input_source_mode_set(_mode)
{
    __input_initialize();
    
    if (_mode != global.__input_source_mode)
    {
        global.__input_previous_source_mode = global.__input_source_mode;
        
        switch(_mode)
        {
            case INPUT_SOURCE_MODE.FIXED:
                //Do nothing!
            break;
            
            case INPUT_SOURCE_MODE.JOIN:
                __input_trace("Storing previous source mode (", global.__input_previous_source_mode, ")");
            break;
            
            case INPUT_SOURCE_MODE.HOTSWAP:
                //Clear the sources for every player apart from player 0
                var _i = 1;
                repeat(INPUT_MAX_PLAYERS-1)
                {
                    input_source_clear(_i);
                    ++_i;
                }
            break;
            
            case INPUT_SOURCE_MODE.MIXED:
            case INPUT_SOURCE_MODE.MULTIDEVICE:
                //Assign every possible source to player 0
                //This implicitly clears all sources from all other players
                input_source_set(all, 0, false);
            break;
        }
    }
    
    global.__input_source_mode = _mode;
}