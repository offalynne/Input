// Feather disable all

/// Creates a formatted error message and shows it to the player. This error message uses
/// GameMaker's error dialog box and will terminate the application when it is dismissed. The error
/// message itself is made from the concatenated stringified values passed to this function.
/// 
/// @param string
/// @param ...

function InputPlugInError()
{
   var _argumentArray = ["Plug-In Error\n"];
   repeat(argument_count) array_push(_argumentArray, argument[array_length(_argumentArray) - 1]);   
   method_call(__InputError, _argumentArray);
}
