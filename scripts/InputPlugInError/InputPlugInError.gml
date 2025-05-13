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
   var _i = 0;
   repeat(argument_count) 
   {
       array_push(_argumentArray, argument[_i]);
       ++_i;
   } 
   method_call(__InputError, _argumentArray);
}
