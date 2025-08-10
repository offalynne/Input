// Feather disable all

//The coordinate space that cursors should exist in. You can convert between coordinate spaces when
//getting cursor values but the elastic and limit features will only be applied in the primary
//coordinate space.
#macro INPUT_CURSOR_PRIMARY_COORD_SPACE  INPUT_CURSOR_ROOM_SPACE

//Whether a player's cursor should follow the mouse when using the `INPUT_KBM` deivce (keyboard
//and mouse). Set this macro to `false` to make the keyboard move the cursor via the cluster
//defined below.
#macro INPUT_CURSOR_MOUSE_CONTROL  true

//Cluster to read to move cursors when using a gamepad or keyboard. This cluster should be defined
//alongside verbs and other clusters in `__InputConfigVerbs()`, for example INPUT_CLUSTER.NAVIGATION
#macro INPUT_CURSOR_CLUSTER  -1

//Default speed of the cursor when using a gamepad or keyboard. This value is measured in pixels
//per frame and as such is *not* inherently delta-timed. You can change the cursor speed at runtime
//by calling `InputCursorSetSpeed()`.
#macro INPUT_CURSOR_DEFAULT_SPEED  8

//Movement exponent, applied when using a gamepad or keyboard. This value is very sensitive to
//change it slowly whilst testing!
#macro INPUT_CURSOR_EXPONENT  1