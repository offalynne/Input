var _device = InputPlayerGetDevice();

if (keyboard_check_pressed(vk_space))
{
    InputDeviceSetRebinding(_device, true);
}

var _result = InputDeviceGetRebindingResult(_device);
if (_result != undefined)
{
    InputBindingSet(InputDeviceIsGamepad(_device), INPUT_VERB.SPECIAL, _result);
    InputDeviceSetRebinding(_device, false);
}

if (keyboard_check(vk_control) && keyboard_check_pressed(ord("S")))
{
    if (InputDeviceIsGamepad(_device))
    {
        exportedGamepadBindings = InputBindingsExport(true);
    }
    else
    {
        exportedKeyboardBindings = InputBindingsExport(false);
    }
}

if (keyboard_check(vk_control) && keyboard_check_pressed(ord("O")))
{
    if (InputDeviceIsGamepad(_device))
    {
        InputBindingsImport(true, exportedGamepadBindings);
    }
    else
    {
        InputBindingsImport(false, exportedKeyboardBindings);
    }
}