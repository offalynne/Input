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
	
	show_debug_message("InputCat: Testing plug-ins");
	show_debug_message($"InputCat: \"InputIcons\" {InputPlugInIsRegistered("InputIcons")}");
	show_debug_message($"InputCat: \"InputMotion\" {InputPlugInIsRegistered("InputMotion")}");
	show_debug_message($"InputCat: \"InputColor\" {InputPlugInIsRegistered("InputColor")}");
	show_debug_message($"InputCat: \"InputParty\" {InputPlugInIsRegistered("InputParty")}");
	show_debug_message($"InputCat: \"InputTriggerEffect\" {InputPlugInIsRegistered("InputTriggerEffect")}");
	show_debug_message($"InputCat: \"InputVibrate\" {InputPlugInIsRegistered("InputVibrate")}");
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