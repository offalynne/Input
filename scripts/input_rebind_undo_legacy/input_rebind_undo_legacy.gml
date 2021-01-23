function input_rebind_undo_legacy()
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
                if (is_struct(rebind_backup_collision_ref))
                {
                    __input_trace("Rebinding undoing collision");
                    __input_binding_overwrite(rebind_backup_collision_val, rebind_backup_collision_ref);
                }
                
                __input_trace("Rebinding undo successful (source=", rebind_source, ", verb=", rebind_verb, ", alternate=", rebind_alternate, "). Overwriting ", _binding, " with backup ", rebind_backup_val);
                __input_binding_overwrite(rebind_backup_val, _binding);
                
                return true;
            }
        }
    }
    
    __input_trace("Rebinding undo failed");
    return false;
}

function input_rebind_undo()
{
    __input_error("input_rebind_undo() has been deprecated, please use input_rebind_undo_legacy() instead\nThis feature will be replaced in a future update");
    
    input_rebind_undo_legacy();
}