//Maximum number of players that the game supports
//For a singleplayer only game, this macro should be set to 1
#macro INPUT_MAX_PLAYERS  4

//Verb to use to allow a player to cancel the INPUT_SOURCE_MODE.JOIN source mode (multiplayer source assignment)
//If you want to prevent a player from leaving the session then set this macro to <undefined>
#macro INPUT_MULTIPLAYER_LEAVE_VERB  "cancel"

//The function to call when a player tries to abort the INPUT_SOURCE_MODE.JOIN source mode (multiplayer source assignment)
//This macro must be set to a function or script for INPUT_SOURCE_MODE.JOIN to work
#macro INPUT_MULTIPLAYER_ABORT_CALLBACK  undefined