// Feather disable all
function __input_gamepad_type_swap_ab(_gamepad_type)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_global.__ps_region_swap) return true;
    
    switch(_gamepad_type)
    {
        case INPUT_GAMEPAD_TYPE_SWITCH:
        case INPUT_GAMEPAD_TYPE_JOYCON_LEFT:
        case INPUT_GAMEPAD_TYPE_JOYCON_RIGHT:
        //Optional simple types (see __input_define_gamepad_types)
        case "super famicom":
        case "8bitdo":
        case "snes":
            return INPUT_SWITCH_SWAP_AB;
        break;
    }
    
    return false;
}
