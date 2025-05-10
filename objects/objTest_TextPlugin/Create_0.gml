log = "";

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
            var _cursor = ((current_time div 250) mod 2 == 0)? "|" : "";
            return (selected? InputTextRequestGetString() + _cursor : text);
        };
        
        static OnClick = function()
        {
            selected = true;
            InputTextRequestStart(caption, text, maxLength, function()
            {
                selected = false;
                text = InputTextRequestGetString();
            })
        };
}

buttons = [
    new _button("Textfield #1", "Hello",      23, InputVirtualCreate().Button().Rectangle(_vw,   200, _vw*4, 250)),
    new _button("Textfield #2", "GM Kitchen", 32, InputVirtualCreate().Button().Rectangle(_vw*5, 200, _vw*9, 250))
];

background = InputVirtualCreate().Button().Rectangle(0, 0, room_width, room_height);