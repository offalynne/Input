// step
var _controller = InputPlayerUsingGamepad() ? "YES" : "no";
var _pressed    = InputPressed(INPUT_VERB.ACCEPT) ? "PRESSED" : "unpressed";
var _held       = InputCheck(INPUT_VERB.ACCEPT) ? "HELD" : "unheld";

show_debug_message($"time = {string_format(current_time, 7, 0)} frame = {__InputSystem().__frame}, controller : {_controller}, Check : {_pressed}, {_held}");

InputSetHotswapCallback(function()
{
    show_debug_message($"time = {string_format(current_time, 7, 0)} frame = {__InputSystem().__frame}, hotswapped!");
});