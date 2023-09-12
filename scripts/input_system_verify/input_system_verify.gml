// Feather disable all
/// @desc    Reads a JSON (string or struct) that contains Input system data and verifies if it can be imported without error
/// @param   stringOrStruct
/// @param   [returnError=false]

function input_system_verify(_json, _return_error = false)
{
    //Make a clone of the current settings
    var _backup = input_system_export(false);
    
    //Try to import the provided data
    var _error = undefined;
    try
    {
        input_system_import(_json);
    }
    catch(_error)
    {
        __input_trace("input_system_verify() failed with the following error: ", _error);
    }
    
    //Restore the clone of the current settings
    input_system_import(_backup);
    
    if (_return_error)
    {
        return _error;
    }
    else
    {
        return (_error == undefined);
    }
}
