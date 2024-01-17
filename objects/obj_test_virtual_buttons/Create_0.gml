a = input_virtual_create()
    .rectangle(10, 210, 160, 360)
    .button("accept");

b = input_virtual_create()
    .circle(400, 550, 100)
    .follow(true)

c = input_virtual_create()
    .rectangle(410, 210, 660, 310)
    .active(false)
    .follow(true)

d = input_virtual_create()
    .circle(900, 300, 60)
    .active(true)
    .thumbstick(undefined, "left", "right", "up", "down");

e = input_virtual_create()
    .rectangle(550, 450, 750, 650)
    .threshold(0, 20)
    .touchpad(undefined, "left", "right", "up", "down");

// Horizontal single axis DPAD
f = input_virtual_create()
    .rectangle(800, 410, 1000, 510)
    .hpad(undefined, "left", "right")
    .active(true);

// Vertical single axis DPAD
g = input_virtual_create()
    .rectangle(1050, 310, 1150, 550)
    .vpad(undefined, "up", "down")
    .active(true);

// Full DPAD
h = input_virtual_create()
    .rectangle(830, 540, 970, 680)
    .dpad(undefined, "left", "right", "up", "down", false)
    .active(true);

// Momentary button for button-mashing on a touchscreen
i = input_virtual_create()
    .rectangle(900, 50, 1250, 300)
    .button("accept")
    .momentary(true);

test_x = room_width / 2;
test_y = room_height / 2;

// Helper to get string of the vbutton type currently being pressed
type_str = {};
type_str[$ INPUT_VIRTUAL_TYPE.BUTTON] = "Button";
type_str[$ INPUT_VIRTUAL_TYPE.DPAD_4DIR] = "DPAD 4-Direction";
type_str[$ INPUT_VIRTUAL_TYPE.DPAD_8DIR] = "DPAD 8-Direction";
type_str[$ INPUT_VIRTUAL_TYPE.DPAD_HORIZONTAL] = "DPAD Horizontal";
type_str[$ INPUT_VIRTUAL_TYPE.DPAD_VERTICAL] = "DPAD Vertical";
type_str[$ INPUT_VIRTUAL_TYPE.THUMBSTICK] = "Thumbstick";
type_str[$ INPUT_VIRTUAL_TYPE.TOUCHPAD] = "Touchpad";
pressed_vbutton_type = function() {
    static _vbutton_arr = [a, b, c, d, e, f, g, h, i];
    static _len = array_length(_vbutton_arr);
    for(var _i = 0; _i<_len; _i++) {
        if(_vbutton_arr[_i].check()) {
            return type_str[$ _vbutton_arr[_i].get_type()] ?? "";
            break;
        }
    }		
    return ""; // failsafe..
}