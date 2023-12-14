a = input_virtual_create()
    .rectangle(10, 210, 160, 360)
    .button("accept");

b = input_virtual_create()
    //.circle(500, 300, 120)
    .rectangle(410, 210, 660, 310)
    .active(false)
    .follow(true)

// Thumbstick
c = input_virtual_create()
    .circle(900, 300, 60)
    .active(true)
    .thumbstick(undefined, "left", "right", "up", "down");

// Horizontal single axis DPAD
d = input_virtual_create()
    .rectangle(800, 410, 1000, 510)
	.hpad(undefined, "left", "right")
	.active(true);

// Vertical single axis DPAD
e = input_virtual_create()
    .rectangle(1050, 310, 1150, 550)
	.vpad(undefined, "up", "down")
	.active(true);

// Full DPAD
f = input_virtual_create()
    .rectangle(830, 540, 970, 680)
	.dpad(undefined, "left", "right", "up", "down", false)
	.active(true);

test_x = room_width / 2;
test_y = room_height / 2;