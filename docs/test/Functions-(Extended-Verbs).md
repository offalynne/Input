# Functions (Extended Verbs)

&nbsp;

The functions on this page allow you to create complex verbs. These verbs can be checked using the standard [verb checkers](Functions-(Checkers)) but, due to their complexity, they require custom definition code.

Chord- and combo-type verbs exist "globally": once defined, every player will have access to these verbs. They cannot be modified with the normal [binding access functions](Functions-(Binding-Access)).

&nbsp;

## `input_chord_create(name, maxTimeBetweenPresses, verb1, verb2, ...)`

*Returns:* N/A (`undefined`)

|Name                   |Datatype                  |Purpose                                                                                                                        |
|-----------------------|--------------------------|-------------------------------------------------------------------------------------------------------------------------------|
|`name`                 |string                    |Name of the chord verb to create                                                                                               |
|`maxTimeBetweenPresses`|number                    |Maximum time allowed between verb activations, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|
|`verb1`                |[verb](Verbs-and-Bindings)|Name of a required [verb](Verbs-and-Bindings)                                                                                  |
|`verb2`                |[verb](Verbs-and-Bindings)|Name of a required [verb](Verbs-and-Bindings)                                                                                  |
|...                    |                          |etc.                                                                                                                           |

A "chord" is a set of verbs that must be pressed together, for example `ctrl + alt + delete` or `ctrl + S`. When all of the specified verbs are pressed together, the chord verb itself is activated. If there is too much time between individual key presses, determined by the `maxTimeBetweenPresses` argument, then the chord verb will fail to activate.