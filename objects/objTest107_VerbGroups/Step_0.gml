//Uncomment if you want to test

/*

var _device = InputPlayerGetDevice();

if (InputDeviceGetRebinding(_device))
{
    if (keyboard_check(vk_escape))
    {
        //Hardcoded
        InputDeviceSetRebinding(_device, false);
    }
    else
    {
        var _result = InputDeviceGetRebindingResult(_device);
        if (_result != undefined)
        {
            InputBindingSetSafe(InputDeviceIsGamepad(_device), rebindingVerb, _result);
            InputDeviceSetRebinding(_device, false);
        }
    }
}
else
{
    var _count = array_length(InputPlugInGetAllVerbs());
    var _delta = -InputOpposingRepeat(INPUT_VERB.DOWN, INPUT_VERB.UP);
    rebindingVerb = (rebindingVerb + _delta + _count) mod _count;
    
    if (InputPressed(INPUT_VERB.ACCEPT))
    {
        InputDeviceSetRebinding(_device, true);
    }
    
    if (InputPressed(INPUT_VERB.SPECIAL))
    {
        InputVerbGroupSetActive(INPUT_VERB_GROUP.EXAMPLE_A, not InputVerbGroupGetActive(INPUT_VERB_GROUP.EXAMPLE_A));
    }
}

//*/