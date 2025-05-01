var _device = InputPlayerGetDevice();

var _string = string_join("\n",
    string_concat("Rebinding \"", InputDeviceGetDescription(_device), "\" = ", InputDeviceGetRebinding(_device)? "true" : "false"),
    string_concat("\"special\" binding = ", InputVerbGetBindingName(INPUT_VERB.SPECIAL)),
    " ",
    "[space] = Start rebinding",
    "[ctrl+S] = Save bindings",
    "[ctrl+O] = Load bindings"
);

draw_text(10, 10, _string);