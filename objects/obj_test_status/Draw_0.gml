var _players_status = input_players_get_status();
if (_players_status.any_changed) show_debug_message("Players: " + string(_players_status));

var _gamepads_status = input_gamepads_get_status();
if (_gamepads_status.any_changed) show_debug_message("Gamepads: " + string(_gamepads_status));

var _string = "";
_string += "Players:" + string(_players_status) + "\n";
_string += "\n";
_string += "Gamepads:" + string(_gamepads_status) + "\n";

draw_text_ext(10, 10, _string, -1, room_width-10);