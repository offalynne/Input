draw_text(10,  10, "keyboard_string  >" + keyboard_string  + "<");
draw_text(10,  30, "Length           "  + string(string_length(keyboard_string)));
draw_text(10,  70, "Delta            >" + InputTextDelta() + "<");
draw_text(10,  90, "Deletions        "  + string(InputTextCharsRemoved()));
draw_text(10, 110, "RequestStatus    "  + debugStatus[InputTextRequestGetStatus()]);
//draw_text(10, 130, "RequestString    >" + InputTextRequestGetString() + _cursor);

InputVirtualDebugDraw();

var _i = 0;
repeat(array_length(buttons))
{
    with(buttons[_i])
    {
        draw_text(button.GetPosition().left + 15, button.GetPosition().top + 15, DrawValue());
        if (button.Pressed()) OnClick();
    }
    
    ++_i;
}

if (keyboard_check_pressed(vk_escape) || background.Pressed())
{
    InputTextRequestStop();
}