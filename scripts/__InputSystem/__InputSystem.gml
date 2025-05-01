// Feather disable all

#macro __INPUT_VERB_STATE_HEADER  "<PWP"
#macro __INPUT_VERB_STATE_FOOTER  ">"

#macro __INPUT_CONTROLLER_OBJECT_DEPTH  16001

// Whether the game uses the horizontal holdtype for single Joy-Cons. Set this to `false` for
// vertical holdtype when running on Switch. The library treats these two modes as mutually
// exclusive (come talk to us if you need to be able to swap at runtime).
#macro __INPUT_SWITCH_JOYCON_HORIZONTAL_HOLDTYPE  true

#macro __INPUT_VALIDATE_PLAYER_INDEX if (INPUT_SAFETY_CHECKS)\
                                     {\
                                         if (not is_numeric(_playerIndex))\
                                         {\
                                             __InputError($"Player index must be a number (typeof = \"{typeof(_playerIndex)}\")");\
                                         }\
                                         if (_playerIndex >= INPUT_MAX_PLAYERS)\
                                         {\
                                             __InputError($"Player index {_playerIndex} too large. Must be less than config `INPUT_MAX_PLAYERS` ({INPUT_MAX_PLAYERS})");\
                                         }\
                                         if (_playerIndex < 0)\
                                         {\
                                             __InputError($"Player index {_playerIndex} less than zero");\
                                         }\
                                     }

__InputSystem();
function __InputSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    __InputTrace("Welcome to Input by Juju Adams, Alynne Keith, and friends! This is version " + INPUT_VERSION + ", " + INPUT_DATE);
    
    device_mouse_dbclick_enable(false);
    
    _system = {};
    if (INPUT_RUNNING_FROM_IDE) global.Input = _system;
    
    with(_system)
    {
        __InputInitializeSteam();
        
        __deviceMap = ds_map_create();
        
        __frame = 0;
        __time  = 0;
        
        __lowestConnectedPlayerIndex = undefined;
        
        __hotswap = (not INPUT_BAN_HOTSWAP);
        __hotswapCallback = undefined;
        
        __rebindingMap   = ds_map_create();
        __rebindingArray = [];
        
        __gamepadArray = array_create(gamepad_get_device_count(), undefined);
        
        //Master definitions for verbs
        __verbDefinitionArray = []; //Contains structs for each verb definition
        __verbDefIndexArray   = []; //Contains verb indexes for each verb definition. The verb index values are usually sequential and continuous but not always!
        __verbExportNameDict  = {};
        __verbCount           = 0;
        
        __clusterDefinitionArray = [];
        __clusterCount           = 0;
        
        __kbmBindingNameMap       = __InputCreateKbmBindingNameMap();
        __gamepadButtonNameLookup = __InputCreateGamepadBindingNameLookup();
        
        //Instantiated in __InputSystemPlayerArray()
        __playerArray = undefined;
        
        //Pointer abstraction for mouse/touch input
        __pointerBlockedByUser = false;
        __pointerBlockedByUserThisFrame = false;
        
        __pointerBlocked     = false;
        __pointerMoved       = false;
        __prevPointerDeviceX = 0;
        __prevPointerDeviceY = 0;
        __pointerDeviceX     = 0;
        __pointerDeviceY     = 0;
        __pointerRoomX       = 0;
        __pointerRoomY       = 0;
        __pointerGuiX        = 0;
        __pointerGuiY        = 0;
        
        //Window touchpad/touchscreen fixes
        __tapClick    = false;
        __tapPresses  = 0;
        __tapReleases = 0;
        
        __windowFocus = true;
        __pointerBlockedByWindowDefocus = false;
        
        //Virtual button storage
        __virtualOrderDirty  = false;
        __virtualButtonArray = [];
        
        __plugInCurrentCallback = undefined;
        __plugInCallbackArray = __InputSystemCallbackArray();
        
        __InputRegisterCollect();
        __InputRegisterCollectPlayer();
        __InputRegisterUpdate();
        __InputRegisterUpdatePlayer();
        __InputRegisterGamepadDisconnected();
        __InputRegisterGamepadConnected();
        __InputRegisterPlayerDeviceChanged();
        
        var _returnNull = function()
        {
            return 0;
        }
        
        __genericReadArray = [
            gamepad_button_value, // 32769 = gp_face1
            gamepad_button_value, // 32770 = gp_face2
            gamepad_button_value, // 32771 = gp_face3
            gamepad_button_value, // 32772 = gp_face4
            gamepad_button_value, // 32773 = gp_shoulderl
            gamepad_button_value, // 32774 = gp_shoulderr
            gamepad_button_value, // 32775 = gp_shoulderlb
            gamepad_button_value, // 32776 = gp_shoulderrb
            gamepad_button_value, // 32777 = gp_select
            gamepad_button_value, // 32778 = gp_start
            gamepad_button_value, // 32779 = gp_stickl
            gamepad_button_value, // 32780 = gp_stickr
            gamepad_button_value, // 32781 = gp_padu
            gamepad_button_value, // 32782 = gp_padd
            gamepad_button_value, // 32783 = gp_padl
            gamepad_button_value, // 32784 = gp_padr
            gamepad_axis_value,   // 32785 = gp_axislh
            gamepad_axis_value,   // 32786 = gp_axislv
            gamepad_axis_value,   // 32787 = gp_axisrh
            gamepad_axis_value,   // 32788 = gp_axisrv
            _returnNull,          // 32789
            _returnNull,          // 32790
            _returnNull,          // 32791
            _returnNull,          // 32792
            _returnNull,          // 32793
            _returnNull,          // 32794
            _returnNull,          // 32795
            _returnNull,          // 32796
            _returnNull,          // 32797
            _returnNull,          // 32798
            gamepad_button_value, // 32799 = gp_home
            gamepad_button_value, // 32800 = gp_extra1
            gamepad_button_value, // 32801 = gp_extra2
            gamepad_button_value, // 32802 = gp_extra3
            gamepad_button_value, // 32803 = gp_extra4
            gamepad_button_value, // 32804 = gp_paddler
            gamepad_button_value, // 32805 = gp_paddlel
            gamepad_button_value, // 32806 = gp_paddlerb
            gamepad_button_value, // 32807 = gp_paddlelb
            gamepad_button_value, // 32808 = gp_touchpadbutton
            gamepad_button_value, // 32809 = gp_extra5
            gamepad_button_value, // 32810 = gp_extra6
        ];
        
        
        
        __InputConfigVerbs();
        
        
        
        //Set a default device for player 0
        if (INPUT_ON_MOBILE)
        {
            InputPlayerSetDevice(INPUT_TOUCH);
        }
        else if (INPUT_ON_DESKTOP)
        {
            InputPlayerSetDevice(INPUT_KBM);
        }
        else if (INPUT_ON_CONSOLE)
        {
            var _i = 0;
            repeat(gamepad_get_device_count())
            {
                if (InputDeviceIsConnected(_i)) InputPlayerSetDevice(_i);
                ++_i;
            }
        }
        
        //Create a time source if the library needs to self-manage
        if (INPUT_COLLECT_MODE != 2)
        {
            time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function()
            {
                if (INPUT_COLLECT_MODE == 1)
                {
                    __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.COLLECT);
                    if (INPUT_UPDATE_AFTER_COLLECT) __InputPlugInExecuteCallbacks(INPUT_PLUG_IN_CALLBACK.UPDATE);
                }
                else if (INPUT_COLLECT_MODE == 0)
                {
                    //Ensure existance of our controller object
                    if (!instance_exists(__InputUpdateController))
                    {
                        //Try to detect deactivation of the controller object
                        instance_activate_object(__InputUpdateController);
                        if (instance_exists(__InputUpdateController))
                        {
                            if (GM_build_type == "run")
                            {
                                //Be nasty when running from the IDE >:(
                                __InputError("__InputUpdateController has been deactivated\nPlease ensure that __InputUpdateController is never deactivated\nYou may need to use instance_activate_object(__InputUpdateController)");
                            }
                            else
                            {
                                //Be nice when in production <:)
                                __InputTrace("Warning! __InputUpdateController has been deactivated. Please ensure that __InputUpdateController is never deactivated. You may need to use instance_activate_object(__InputUpdateController)");
                            }
                        }
                        else
                        {
                            static _created = false;
                            if (not _created)
                            {
                                //Don't throw an error if we haven't made the instance yet
                                _created = true;
                            }
                            else
                            {
                                if (GM_build_type == "run")
                                {
                                    //Be nasty when running from the IDE >:(
                                    __InputError("__InputUpdateController has been destroyed\nPlease ensure that __InputUpdateController is never destroyed");
                                }
                                else
                                {
                                    //Be nice when in production <:)
                                    __InputTrace("Warning! __InputUpdateController has been destroyed. Please ensure that __InputUpdateController is never destroyed");
                                }
                            }
                
                            instance_create_depth(0, -__INPUT_CONTROLLER_OBJECT_DEPTH, __INPUT_CONTROLLER_OBJECT_DEPTH, __InputUpdateController);
                        }
                    }
        
                    //Detect if the controller object has been set to non-persistent
                    if (!__InputUpdateController.persistent)
                    {
                        if (GM_build_type == "run")
                        {
                            //Be nasty when running from the IDE >:(
                            __InputError("__InputUpdateController has been set as non-persistent\nPlease ensure that __InputUpdateController is always persistent");
                        }
                        else
                        {
                            //Be nice when in production <:)
                            __InputTrace("Warning! __InputUpdateController has been set as non-persistent. Please ensure that __InputUpdateController is always persistent");
                            __InputUpdateController.persistent = true;
                        }
                    }
        
                    //Detect if the controller object depth has been set
                    if (__InputUpdateController.depth != __INPUT_CONTROLLER_OBJECT_DEPTH)
                    {
                        if (GM_build_type == "run")
                        {
                            //Be nasty when running from the IDE >:(
                            __InputError("__InputUpdateController depth has been changed (expected ", __INPUT_CONTROLLER_OBJECT_DEPTH, ", got ", __InputUpdateController.depth ,")\nPlease ensure that __InputUpdateController is never manually created and depth is not manually set");
                        }
                        else
                        {
                            //Be nice when in production <:)
                            __InputTrace("Warning! __InputUpdateController depth has been changed (expected ", __INPUT_CONTROLLER_OBJECT_DEPTH, ", got ", __InputUpdateController.depth ,")\nPlease ensure that __InputUpdateController is never manually created and depth is not manually set");
                            __InputUpdateController.depth = __INPUT_CONTROLLER_OBJECT_DEPTH;
                        }
                    }
                }
            },
            [], -1));
        }
    }
    
    return _system;
}