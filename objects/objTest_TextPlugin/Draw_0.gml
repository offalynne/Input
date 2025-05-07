var _waiting = true;
if (InputTextRequestGetStatus() != INPUT_TEXT_REQUEST_STATUS.WAITING)
{
    _waiting = false;    
    if (InputPressed(INPUT_VERB.ACCEPT))
    {
        InputTextRequest("Hello", text, 32, function(){
            text = InputTextRequestGetString();
        })
    }
}

var _cursor = "";
if (_waiting)
{
    _cursor = " "; 
    if ((current_time div 500) mod 2 == 0)
    {
        _cursor = "|"
    }
}

draw_text(10,  10, "keyboard_string   \"" + keyboard_string  + "\"");
draw_text(10,  40, "Delta             \"" + InputTextDelta() + "\"");
draw_text(10,  60, "Deletions         "   + string(InputTextCharsRemoved()));
draw_text(10,  90, "Status            "   + string(InputTextRequestGetStatus()));
draw_text(10, 110, "String            \"" + InputTextRequestGetString() + _cursor + "\"");