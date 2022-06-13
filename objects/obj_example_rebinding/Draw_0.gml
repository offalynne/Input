var _string = "";
_string += "Rebinding Example\n";
_string += "\n";
_string += input_binding_get_icon(input_binding_get("pause")) + " = Pause/Unpause\n";

//Show the rebinding menu if we're paused
if (pause)
{
    _string += "\n";
    _string += "\n";
    
    if (!input_binding_scan_in_progress())
    {
        _string += "Please select a verb to rebind:\n";
        _string += "\n";
        
        //This is a bit clumsy but sufficient for this example
        //In a real situation you'll probably want to handle this with an array
        if (menu_selection == 0) _string += "-->  ";
        _string += input_binding_get_icon(input_binding_get("left")) + " = Left\n";
        
        if (menu_selection == 1) _string += "-->  ";
        _string += input_binding_get_icon(input_binding_get("right")) + " = Right\n";
        
        if (menu_selection == 2) _string += "-->  ";
        _string += input_binding_get_icon(input_binding_get("up")) + " = Up\n";
        
        if (menu_selection == 3) _string += "-->  ";
        _string += input_binding_get_icon(input_binding_get("down")) + " = Down\n";
        
        if (menu_selection == 4) _string += "-->  ";
        _string += input_binding_get_icon(input_binding_get("accept")) + " = Accept\n";
    }
    else
    {
        //Display what verb we're rebinding if we're scanning for a new verb
        _string += "Rebinding \"" + rebinding_verb + "\"\n";
    }
}
else
{
    //Display a control prompt for basic player movement
    _string += input_binding_get_icon(input_binding_get("left")) + "/" + input_binding_get_icon(input_binding_get("right")) + "/" + input_binding_get_icon(input_binding_get("up")) + "/" + input_binding_get_icon(input_binding_get("down")) + " = Move\n";
}

draw_text(10, 10, _string);