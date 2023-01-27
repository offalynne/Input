a = input_virtual_create()
    .rectangle(10, 210, 160, 360)
    .button("accept");

b = input_virtual_create()
    .circle(500, 300, 120)
    .active(false)
    .thumbstick(undefined, "left", "right", "up", "down");