// Feather disable all

if (INPUT_MAX_PLAYERS < 2)
{
    __InputError($"`INPUT_MAX_PLAYERS` ({INPUT_MAX_PLAYERS}) must be set to 2 or more");
}

InputPartySetParams(INPUT_VERB.ACCEPT, 2, 2, true, INPUT_VERB.CANCEL, function() { show_debug_message("Aborted!") }, true);
InputPartySetJoin(true)