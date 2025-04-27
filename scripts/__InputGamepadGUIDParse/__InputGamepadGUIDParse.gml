// Feather disable all

/// @param GUID
/// @param legacy

function __InputGamepadGUIDParse(_guid, _legacy)
{
    static _result = {};
    
    _result.__vendor      = "";
    _result.__product     = "";
    _result.__description = undefined;
    
    if (_guid == "00000000000000000000000000000000")
    {
        __InputTrace("Warning! GUID was empty");
        return _result;
    }
    
    if (_legacy)
    {
        //GM on Windows uses an older version of SDL so we strip out VID + PID as a special case
        _result.__vendor  = string_copy(_guid, 1, 4);
        _result.__product = string_copy(_guid, 5, 4);
        return _result;
    }
    
    //Expected GUID pattern:
    // 
    //  ****0000****0000****0000****XXXX
    //  N1  N2  N3  N4  N5  N6  N7  N8
    //
    // N1: Bus (OS driver)
    // N3: Vendor ID
    // N5: Product ID
    // N7: Revision
    // N8: Driver hint (SDL)
    //
    //If instead of the expected VID + PID + REV pattern, GUID is used to encode device
    //description, N3 onwards contains encoded description instead of indicated values.
    //On Android platform, GUID description encoding begins at N1 and will not mismatch
    
    //Check for non-empty N4, indicating this is a description encoded GUID
    if (string_copy(_guid, 13, 4) != "0000")
    {
        _result.__description = string_copy(_guid, 1, 20); //Match to minimum description length, N1 - N5
    }
    else
    {
        //Otherwise confirm N6 is also empty
        if (string_copy(_guid, 21, 4) != "0000")
        {
            __InputTrace("Warning! GUID \"", _guid, "\" does not fit expected pattern. VID+PID cannot be extracted");
            return _result;
        }
        
        //Check to see if N1 for this GUID is what we expect (OS bus for USB or Bluetooth)
        //In some cases, what we expect for this value is going to be different, so this isn't necessarily something that invalidates VID+PID checking
        if ((string_copy(_guid, 1, 4) != "0300") 
        &&  (string_copy(_guid, 1, 4) != "0500"))
        {
            __InputTrace("Warning! GUID \"", _guid, "\" driver ID does not match expected (Found ", string_copy(_guid, 1, 4), ", expect either 0300 or 0500)");
        }
        
        _result.__vendor  = string_copy(_guid,  9, 4);
        _result.__product = string_copy(_guid, 17, 4);
    }
    
    return _result;
}
