// Feather disable all
/// Decodes an CSV string and outputs a 2D array
///
/// @return 2D array that represents the contents of the CSV string
/// 
/// @param string              The CSV string to be decoded
/// @param [cellDelimiter]     Character to use to indicate where cells start and end

function __input_csv_to_array(_csv_string, _cell_delimiter = ",")
{
    var _lines = string_split(_csv_string, "\n", true);
    var _array = [];
    
    var _i = 0;
    repeat(array_length(_lines))
    {
        array_push(_array, string_split(_lines[_i], _cell_delimiter, true));
        
        ++_i;
    }
    
    return _array;
}
