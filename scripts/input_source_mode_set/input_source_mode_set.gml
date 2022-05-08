/// @param mode

function input_source_mode_set(_mode)
{
    __input_initialize();
    
    if (_mode != global.__input_source_mode)
    {
        switch(_mode)
        {
            case INPUT_SOURCE_MODE.FIXED:
            case INPUT_SOURCE_MODE.JOIN:
                //Do nothing!
            break;
            
            case INPUT_SOURCE_MODE.HOTSWAP:
            case INPUT_SOURCE_MODE.MULTI_DEVICE:
                //Clear the sources for every player apart from player 0
                var _i = 1;
                repeat(INPUT_MAX_PLAYERS)
                {
                    input_source_clear(_i);
                    ++_i;
                }
            break;
            
            case INPUT_SOURCE_MODE.MIXED:
                //Assign every possible source to player 0
                input_source_set(all, 0, false);
            break;
        }
    }
    
    global.__input_source_mode = _mode;
}