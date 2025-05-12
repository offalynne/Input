// Feather disable all

function InputPlugInError()
{
   var _argumentArray = ["Plug-In Error\n"];
   repeat(argument_count) array_push(_argumentArray, argument[array_length(_argumentArray)]);   
   method_call(__InputError, _argumentArray);
}
