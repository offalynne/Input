var _string = string_join("\n",
    string_concat("x = ", InputX(INPUT_CLUSTER.NAVIGATION)),
    string_concat("y = ", InputY(INPUT_CLUSTER.NAVIGATION)),
    string_concat("distance = ", InputDistance(INPUT_CLUSTER.NAVIGATION)),
    string_concat("direction = ", InputDirection(inputDirection, INPUT_CLUSTER.NAVIGATION)),
);

draw_text(10, 10, _string);

var _x = room_width/2;
var _y = room_height/2;
var _radius = 250;
var _distance = InputDistance(INPUT_CLUSTER.NAVIGATION);
inputDirection = InputDirection(inputDirection, INPUT_CLUSTER.NAVIGATION);

draw_circle(_x, _y, _radius, true);
draw_arrow(_x, _y, _x + lengthdir_x(_radius*_distance, inputDirection), _y + lengthdir_y(_radius*_distance, inputDirection), 20);