// Feather disable all
__InputTextSystem();
function __InputTextSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
        
    _system = {};
    with(_system)
    {
        __callback  = undefined;
        __asyncId   = undefined;
        __textSet   = undefined;
        __textAsync = undefined;
        
        __repeatCount = 0; 
        __removeCount = 0;
        __textRequest = "";
        __textDelta   = "";        
        
        __newStatus     = undefined;
        __keyboardType  = kbv_type_default;
        __requestStatus = INPUT_TEXT_STATUS.NONE;
        __maxLength     = __INPUT_TEXT_MAX_LENGTH;
        
        __steamAsyncRequest = false;
        __useSteamKeyboard  = false;
        
        if (InputGetSteamInfo(INPUT_STEAM_INFO.STEAMWORKS)
        &&  InputGetSteamInfo(INPUT_STEAM_INFO.STEAM_DECK))
        {
            __useSteamKeyboard = true;
            steam_utils_enable_callbacks();
        }
        
        __keyboardString = "";   
        __keyboardStringPrevious = __keyboardString;

        InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.UPDATE, undefined, function()
        {            
            __InputTextHandleController();
            
            if (__enabled)
            {
                __InputTextHandleKeyboard();
                __InputTextLintKeyboardString();
                __InputTextFindKeyboardDelta();
            }
            
            __InputTextHandleChanges();
            __InputTextHandleStatus();
        })
    }
}
