# Functions (Icons)

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
//TODO lol
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
//TODO lol
```

<!-- tabs:end -->