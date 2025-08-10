// Feather disable all

/// Creates a formatted log message and shows it to the library user. This message uses
/// GameMaker's Output log. The message itself is made from the concatenated stringified
/// values passed to this function.
/// 
/// @param string
/// @param ...

function InputPlugInWarning()
{
   var _argumentArray = ["Plug-In Warning: "];
   repeat(argument_count) array_push(_argumentArray, argument[array_length(_argumentArray) - 1]);   
   method_call(__InputTrace, _argumentArray);
}
