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