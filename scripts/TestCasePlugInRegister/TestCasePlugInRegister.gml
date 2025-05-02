// Feather ignore all

InputPlugInRegisterName("InputCat",,["InputPaws", "InputFeline"], function() {
    show_debug_message("InputCat: Initialized!");
    
    if (InputPlugInIsRegistered("InputFeline")) {
        show_debug_message("InputCat: InputFeline exists! :3");    
    } else {
        show_debug_message("InputCat: InputFeline doesn't exist! >:(");    
    }
    
    if (InputPlugInIsRegistered("InputPaws")) {
        show_debug_message("InputCat: InputPaws exists! :3");    
    } else {
        show_debug_message("InputCat: InputPaws doesn't exist! >:(");    
    }
});

InputPlugInRegisterName("InputDog",,, function() {
    show_debug_message("InputDog: Initialized!");
});

InputPlugInRegisterName("InputPug", "InputDog",, function() {
    show_debug_message("InputPug: Initialized!");
});

InputPlugInRegisterName("InputPaws", ["InputDog", "InputPug"],, function() {
    show_debug_message("InputPaws: Initialized!");
});