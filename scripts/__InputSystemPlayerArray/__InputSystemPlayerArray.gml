// Feather disable all

function __InputSystemPlayerArray()
{
    static _playerArray = (function()
    {
        with(__InputSystem())
        {
            //Cache the number of verbs that we have
            __verbCount    = array_length(__verbDefinitionArray);
            __clusterCount = array_length(__clusterDefinitionArray);
            
            //Clean up any missing definitions in our verbs
            var _i = 0;
            repeat(__verbCount)
            {
                if (not is_struct(__verbDefinitionArray[_i]))
                {
                    __verbDefinitionArray[@ _i] = undefined;
                }
                
                ++_i;
            }
            
            //Instantiate players
            __playerArray = array_create_ext(INPUT_MAX_PLAYERS, function(_index)
            {
                return new __InputClassPlayer(_index);
            });
            
            return __playerArray;
        }
    })();
    
    return _playerArray;
}