if (InputPressed(INPUT_VERB.ACCEPT)) InputTextRequestStart("Hello", InputTextRequestGetString(), 20, function(){ log += debugStatus[InputTextRequestGetStatus()] + "\n" });
if (InputPressed(INPUT_VERB.PAUSE )) InputTextRequestStop();

var _waiting = (InputTextRequestGetStatus() == INPUT_TEXT_REQUEST_STATUS.WAITING);

var _cursor = "<";
if (_waiting)
{
    _cursor = ((current_time div 500) mod 2 == 0)? "|" : " ";
}

draw_text(10,  10, "keyboard_string  >" + keyboard_string  + "<");
draw_text(10,  40, "Delta            >" + InputTextDelta() + "<");
draw_text(10,  60, "Deletions        "  + string(InputTextCharsRemoved()));
draw_text(10,  90, "RequestStatus    "  + debugStatus[InputTextRequestGetStatus()]);
draw_text(10, 110, "RequestString    >" + InputTextRequestGetString() + _cursor);

InputVirtualDebugDraw();

draw_text(room_width - 100, 10, log);