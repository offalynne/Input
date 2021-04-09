/// @param configStruct

function __input_fix_config_struct(_config_struct)
{
    var _source_names = variable_struct_get_names(_config_struct);
    var _j = 0;
    repeat(array_length(_source_names))
    {
        var _source_name = _source_names[_j];
        var _source_struct = _config_struct[$ _source_name];
        
        if (_source_name != "axis_thresholds")
        {
            var _verb_names = variable_struct_get_names(_source_struct);
            var _k = 0;
            repeat(array_length(_verb_names))
            {
                var _verb_name = _verb_names[_k];
                var _alt_array = _source_struct[$ _verb_name];
                
                var _l = 0;
                repeat(array_length(_alt_array))
                {
                    var _binding_struct = _alt_array[_l];
                    
                    if (is_struct(_binding_struct))
                    {
                        if (!variable_struct_exists(_binding_struct, "value"        ) || is_ptr(_binding_struct[$ "value"        ])) _binding_struct.value         = undefined;
                        if (!variable_struct_exists(_binding_struct, "axis_negative") || is_ptr(_binding_struct[$ "axis_negative"])) _binding_struct.axis_negative = undefined;
                    }
                    
                    ++_l;
                }
                
                ++_k
            }
        }
        
        ++_j;
    }
    
    return _config_struct;
}