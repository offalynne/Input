# Icon Config

&nbsp;

`__input_config_icons()` holds code that defines what values [`input_verb_get_icon()`](Functions-(Verbs)?id=input_verb_get_iconverb-playerindex-alternate-profilename) and [`input_binding_get_icon()`](Functions-(Binding-Access)?id=input_binding_get_iconbinding-playerindex)should return for specific bindings for specific [types of gamepad](Functions-(Players)?id=input_player_get_gamepad_typeplayerindex-binding). This script never needs to be directly called in your code, but the script and the struct it contains must be present in a project for Input to work.

For more information on how to customise `__input_config_icons()`, please see information relating to [`input_icons()`](Functions-(Other)?id=input_iconscategoryname), the function used throughout this script.

?> You should edit this script to customise Input for your own purposes.