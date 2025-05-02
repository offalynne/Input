//Feather disable all

InputGetBindingName(InputBindingGet(true, INPUT_VERB.ACCEPT), true, INPUT_GAMEPAD_TYPE_UNKNOWN)

var _string = string_join("\n",
$"INPUT_MAX_PLAYERS = {INPUT_MAX_PLAYERS}",
$" ",
$"InputPartyGetJoin() = {InputPartyGetJoin()}",
$"InputPlayerConnectedCount() = {InputPlayerConnectedCount()}",
$"InputPartyGetReady() = {InputPartyGetReady()}",
$" ",
$"Device 0 = {InputPlayerGetDevice(0)}",
$"Device 1 = {InputPlayerGetDevice(1)}",
$" ",
$"Join = {InputGetBindingName(InputBindingGet(false, INPUT_VERB.ACCEPT))} / {InputGetBindingName(InputBindingGet(true, INPUT_VERB.ACCEPT), true, INPUT_GAMEPAD_TYPE_UNKNOWN)}",
$"Cancel = {InputGetBindingName(InputBindingGet(false, INPUT_VERB.CANCEL))} / {InputGetBindingName(InputBindingGet(true, INPUT_VERB.CANCEL), true, INPUT_GAMEPAD_TYPE_UNKNOWN)}",
$"Restart join mode = J",
$" ",
$"InputPartyGetParams() = {json_stringify(InputPartyGetParams(), true)}",
);

draw_text(10, 10, _string);