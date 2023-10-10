a = input_virtual_create()
    .rectangle(10, 210, 160, 360)
    .button("accept");

b = input_virtual_create()
    .circle(500, 300, 120)
    .follow(true)

c = input_virtual_create()
    .rectangle(410, 210, 660, 310)
    .active(false)
    .follow(true)

d = input_virtual_create()
    .circle(900, 300, 60)
    .active(true)
    .thumbstick(undefined, "left", "right", "up", "down");

d = input_virtual_create()
    .rectangle(600, 400, 800, 600)
    .threshold(0, 20)
    .touchpad(undefined, "left", "right", "up", "down");

test_x = room_width / 2;
test_y = room_height / 2;