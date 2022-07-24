/// @desc    Reads a JSON (string or struct) that contains Input system data and verifies if it can be imported without error.
/// @param   stringOrStruct

function input_system_import(_string)
{
    //Make a clone of the current settings
    var _backup = input_system_export(false);
    
    //Try to import the provided data, but turn off errors since we want the error codes
    global.__input_error_disable = true;
    var _error = input_system_import(_string);
    
    //Restore a clone of the current settings
    input_system_import(_backup);
    
    return _error;
}