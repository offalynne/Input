# Functions (Icons)

&nbsp;

These functions allow you to return icons as defined in [`__input_config_icons()`](https://www.jujuadams.com/Input/#/6.0/Icon-Config). These functions will return whatever is defined in that configuration script, be it a string, a sprite, or something else entirely.

&nbsp;

## …verb_get_icon

`input_verb_get_icon(verb, [playerIndex], [alternate], [profileName])`

<!-- tabs:start -->

#### **Description**

_Returns:_ Various, the icon identifier defined in [`__input_config_icons()`](Configuration?id=icons)

|Name           |Datatype                             |Purpose                                                                                                        |
|---------------|-------------------------------------|---------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings) |[Verb](Verbs-and-Alternate-Bindings) to return the icon for                                                    |
|`[playerIndex]`|integer                              |Player to target. If not specified, player 0 is used                                                           |
|`[alternate]`  |integer                              |[Alternate binding](Verbs-and-Bindings) to target. If not specified, `0` is used                               |
|`[profileName]`|string                               |The [profile](Profiles) to set the verb binding for. If no profile is provided then the current profile is used|

Returns the icon associated with the given verb for the device that the given player is currently using. You should edit [`__input_config_icons()`](Configuration?id=icons) to match the requirements of your game.

#### **Example**

```gml
//Draw an icon sprite for the "jump" verb
//(See __input_config_icons() for configuration)
draw_sprite(input_verb_get_icon("jump"), 0, x, y);
```

<!-- tabs:end -->

&nbsp;

## …binding_get_icon

`input_binding_get_icon(binding, [playerIndex])`

<!-- tabs:start -->

#### **Description**

_Returns:_ Various, the icon identifier defined in [`__input_config_icons()`](Configuration?id=icons)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`binding`      |binding |Binding to return the icon for                      |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Returns the icon associated with the given binding for the device that the given player is currently using. You should edit [`__input_config_icons()`](Configuration?id=icons) to match the requirements of your game.

For example, `input_binding_get_icon(input_binding_get("jump"))` will return an icon for the device matching the binding for the "jump" verb if it is defined.

#### **Example**

```gml
//If the new binding is valid...
if (input_binding_is_valid(newBinding))
{
	//Draw some text to announce the new binding
	draw_set_halign(fa_center);
	draw_text(x, y, "Set a new binding!");
	draw_set_halign(fa_left);

	//And then draw the icon for the new binding
	draw_sprite(input_binding_get_icon(newBinding), 0, x, y + 30);
}
```

<!-- tabs:end -->