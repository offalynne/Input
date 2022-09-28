//What source mode to start the game in
#macro INPUT_STARTING_SOURCE_MODE  INPUT_SOURCE_MODE.HOTSWAP



//Verb to use to allow a player to cancel the INPUT_SOURCE_MODE.JOIN source mode (multiplayer source assignment)
//If you want to prevent a player from leaving the session then set this macro to <undefined>
#macro INPUT_MULTIPLAYER_LEAVE_VERB  "cancel"

//The function to call when a player tries to abort the INPUT_SOURCE_MODE.JOIN source mode (multiplayer source assignment)
//This macro must be set to a function or script for INPUT_SOURCE_MODE.JOIN to work
#macro INPUT_MULTIPLAYER_ABORT_CALLBACK  undefined



//Number of milliseconds between source swaps. This should be longer than a single frame (>17 ms at 60FPS)
#macro INPUT_HOTSWAP_DELAY  33

//Whether to trigger a hotswap when a gamepad axis is moved
#macro INPUT_HOTSWAP_ON_GAMEPAD_AXIS  true

//Whether to trigger a hotswap when a mouse button is pressed
#macro INPUT_HOTSWAP_ON_MOUSE_BUTTON  true

//Whether to trigger a hotswap when the mouse is moved
#macro INPUT_HOTSWAP_ON_MOUSE_MOVEMENT  true

//The function to call when a player hotswaps their device
//Set this macro to <undefined> to not call a function
#macro INPUT_HOTSWAP_CALLBACK  undefined

//Whether to automatically change player 0's profile when they hotswap their source
#macro INPUT_HOTSWAP_AUTO_PROFILE  true