draw_set_color(c_gray);
InputVirtualDebugDraw();
draw_set_color(c_white);

draw_text(10,  10, "keyboard_string  >" + keyboard_string  + "<");
draw_text(10,  30, "Length           "  + string(string_length(keyboard_string)));

draw_text(10,  60, "Delta            >" + InputTextDelta() + "<");
draw_text(10,  80, "Deletions        "  + string(InputTextCharsRemoved()));

draw_text(10, 110, "RequestStatus    "  + debugStatus[InputTextRequestGetStatus()]);

var _i = 0;
repeat(array_length(buttons))
{
    with(buttons[_i])
    {
        if (button.Pressed()) 
        {
            OnClick();
        }
    
        draw_text(
            button.GetPosition().left + 15, 
            button.GetPosition().top  + 15, 
            DrawValue());
    }
    
    ++_i;
}

if (keyboard_check_pressed(vk_escape) || background.Pressed())
{
    InputTextRequestStop();
}