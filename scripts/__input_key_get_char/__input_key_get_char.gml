// Feather disable all

function __input_key_get_char(_keyboard_key)
{
    var _char = string_upper(keyboard_lastchar);
    if (((ord(_char) >= ord("A")) && (ord(_char) <= ord("Z"))) //Basic Latin
    ||  (_keyboard_key == vk_backtick))                        //Backtick or numeric 2
    {
        return _char;
    }

    return undefined;
}
