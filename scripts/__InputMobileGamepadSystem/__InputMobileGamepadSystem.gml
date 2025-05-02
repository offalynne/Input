// Feather disable all

__InputMobileGamepadSystem();
function __InputMobileGamepadSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    if not (INPUT_ON_MOBILE) return _system;
    
    with(_system)
    {
        //Android enumeration
        if (INPUT_ON_ANDROID)
        {
            __enumerationTime = -infinity;

            InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.UPDATE, undefined, function()
            {
                if (InputPlugInGetTime() - __enumerationTime <= INPUT_ANDROID_GAMEPAD_ENUMERATION_INTERVAL) return;
                
                __enumerationTime = InputPlugInGetTime();
                gamepad_enumerate();
            })
        }
        
        //Transform gamepad
        InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.GAMEPAD_CONNECTED, undefined, function(_device)
        {
            //Set type from description
            var _type = InputDeviceGetGamepadType(_device);
            var _descriptionType = __InputMobileGamepadDescriptionType(InputDeviceGetDescription(_device));

            if (_descriptionType != undefined)
            {
                if (_descriptionType != _type)
                {
                    InputPlugInGamepadSetType(_device, _descriptionType);
                }
                
                _type = _descriptionType;
            }
            
            if not (INPUT_ON_IOS) return;

            if (_type == INPUT_GAMEPAD_TYPE_SWITCH)
            {
                //Remap Switch face buttons
                InputPlugInGamepadSetMapping(_device, gp_face1, function(_device) { return gamepad_button_value(_device, gp_face2); });
                InputPlugInGamepadSetMapping(_device, gp_face2, function(_device) { return gamepad_button_value(_device, gp_face1); });
                InputPlugInGamepadSetMapping(_device, gp_face3, function(_device) { return gamepad_button_value(_device, gp_face4); });
                InputPlugInGamepadSetMapping(_device, gp_face4, function(_device) { return gamepad_button_value(_device, gp_face3); });
            }
        })
    }
}