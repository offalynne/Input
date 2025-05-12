debugStatus = [
    "None",
    "Waiting",
    "Stopped",
    "Cancelled",
    "Confirmed",
];

var _vw = room_width/10;

var _button = function(_caption, _text, _maxLength, _button) constructor
{
    caption   = _caption;
    text      = _text;
    maxLength = _maxLength;
    button    = _button;
        
    selected  = false;        
        
    static GetValue = function()
    {
        if (selected)
        {
            return InputTextRequestGetString();
        }
        else
        {
            return text;
        }
    };
    
    static DrawValue = function()
    {
        var _string = GetValue();
        if (!INPUT_ON_CONSOLE && selected && InputGameHasFocus())
        {
            if (((current_time div 250) mod 2 == 0)
            || (string_length(InputTextDelta()) + InputTextCharsRemoved() > 0))
            {
                _string += "|";   
            }
        }
            
        return _string;
    }
        
    static OnClick = function()
    {   
        if (InputTextRequestStart(caption, GetValue(), maxLength, function()
        {
            selected = false;
            text = InputTextRequestGetString();
        }))
        {
            selected = true;
        }
    }
}

buttons = [
    new _button("Textfield #1", "Hello",      23, InputVirtualCreate().Button().Rectangle(_vw,   200, _vw*4, 250)),
    new _button("Textfield #2", "GM Kitchen", 32, InputVirtualCreate().Button().Rectangle(_vw*5, 200, _vw*9, 250))
];

background = InputVirtualCreate().Button().Rectangle(0, 0, room_width, room_height);
