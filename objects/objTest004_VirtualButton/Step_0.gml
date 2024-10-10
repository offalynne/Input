var _i = 0;
repeat(InputVerbCount())
{
    if (InputPressed( _i)) array_insert(eventArray, 0, string_concat("Pressed ", InputVerbGetExportName(_i)));
    if (InputReleased(_i)) array_insert(eventArray, 0, string_concat("Released ", InputVerbGetExportName(_i)));
    
    ++_i;
}