// Feather disable all

__InputPartySystem();
function __InputPartySystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
        __joining = false;
        
        __minPlayers     = 1;
        __maxPlayers     = INPUT_MAX_PLAYERS;
        __fillEmpty      = true;
        __joinVerb       = undefined;
        __leaveVerb      = undefined;
        __abortCallback  = undefined;
        __hotswapOnAbort = true;
        
        InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.UPDATE, undefined, function()
        {
            if (not __joining) return;
            
            if (__joinVerb == undefined)
            {
                __InputError("Join verb not defined. Please call InputPartySetParams()");
            }
            
            if (__fillEmpty)
            {
                //Drop players down into empty spaces
                do
                {
                    var _fail = false;
                    var _p = INPUT_MAX_PLAYERS-1;
                    repeat(INPUT_MAX_PLAYERS-1)
                    {
                        if (InputPlayerIsConnected(_p) && (not InputPlayerIsConnected(_p-1)))
                        {
                            __InputTrace("Moving player ", _p, " (connected) to ", _p-1, " (disconnected)");
                            InputPlayerSwap(_p, _p-1);
                            _fail = true;
                        }
                        
                        --_p;
                    }
                }
                until (not _fail);
            }
            
            //Disconnect all extraneous players
            var _p = __maxPlayers;
            repeat(INPUT_MAX_PLAYERS - __maxPlayers)
            {
                InputPlayerSetDevice(INPUT_NO_DEVICE, _p);
                ++_p;
            }
            
            //Scan for input for the lowest index slot
            var _p = 0;
            repeat(__maxPlayers)
            {
                if (not InputPlayerIsConnected(_p))
                {
                    if (is_callable(__abortCallback) && (InputPlayerConnectedCount() <= 0))
                    {
                        var _device = InputDeviceGetNewActivityOnVerb(__leaveVerb, _p);
                        if (_device != INPUT_NO_DEVICE)
                        {
                            __InputTrace("Player ", _p, " aborted with device ", _device);
                            
                            InputPartySetJoin(false, __hotswapOnAbort);
                            InputPlayerSetDevice(_device, _p);
                            InputVerbConsumeAll(_p); //Make sure we don't leak input
                            
                            __abortCallback();
                            
                            return;
                        }
                    }
                    
                    var _device = InputDeviceGetNewActivityOnVerb(__joinVerb, _p);
                    if (_device != INPUT_NO_DEVICE)
                    {
                        __InputTrace("Player ", _p, " joined with device ", _device);
                        InputPlayerSetDevice(_device, _p);
                        InputVerbConsumeAll(_p); //Make sure we don't leak input
                    }
                }
                
                ++_p;
            }
            
            if (__leaveVerb != undefined)
            {
                //Allow players to leave the game
                var _p = 0;
                repeat(__maxPlayers)
                {
                    if (InputPressed(__leaveVerb, _p))
                    {
                        __InputTrace("Player ", _p, " left");
                        InputPlayerSetDevice(INPUT_NO_DEVICE, _p);
                    }
                    
                    ++_p;
                }
            }
        });
    }
    
    return _system;
}