InputVirtualCreate().Button(INPUT_VERB.ACCEPT).Rectangle(0, 150, room_width/2, room_height/3);
InputVirtualCreate().Button(INPUT_VERB.PAUSE ).Rectangle(room_width/2, 150, room_width, room_height/3);

log = "";

debugStatus = [
    "None",
    "Waiting",
    "Stopped",
    "Cancelled",
    "Confirmed",
];