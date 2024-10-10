var _device = InputPlayerGetDevice();

var _string = string_join("\n",
    string_concat("Rebinding \"", InputDeviceGetDescription(INPUT_KBM), "\" = ", InputDeviceGetRebinding(INPUT_KBM)? "true" : "false"),
    string_concat("Rebinding \"", InputDeviceGetDescription(0), "\" = ", InputDeviceGetRebinding(0)? "true" : "false"),
    string_concat("\"special\" binding = ", InputVerbGetBindingName(INPUT_VERB.SPECIAL)),
);

draw_text(10, 10, _string);