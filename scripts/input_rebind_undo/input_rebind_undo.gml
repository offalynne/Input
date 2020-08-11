function input_rebind_undo()
{
    if (instanceof(global.__input_rebind_last_player) == "__input_class_player")
    {
        with(global.__input_rebind_last_player)
        {
            var _binding = undefined;
            
            var _source_verb_struct = variable_struct_get(config, global.__input_source_names[rebind_source]);
            if (is_struct(_source_verb_struct))
            {
                var _alternate_array = variable_struct_get(_source_verb_struct, rebind_verb);
                if (is_array(_alternate_array))
                {
                    _binding = _alternate_array[rebind_alternate];
                }
            }
            
            if (is_struct(_binding))
            {
                __input_trace("Rebinding undo successful (source=", rebind_source, ", verb=", rebind_verb, ", alternate=", rebind_alternate, "). Overwriting ", _binding, " with backup ", rebind_backup);
                __input_binding_overwrite(rebind_backup, _binding);
                return true;
            }
        }
    }
    
    __input_trace("Rebinding undo failed");
    return false;
}