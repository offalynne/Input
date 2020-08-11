/// @param string
/// @param [playerIndex]

function input_bindings_read()
{
    var _string       = argument[0];
    var _player_index = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : all;
    
    if ((_player_index < 0) && (_player_index != all))
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " vs. ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    var _buffer = buffer_create(string_byte_length(_string), buffer_fixed, 1);
    buffer_write(_buffer, buffer_text, _string);
    buffer_seek(_buffer, buffer_seek_start, 0);
    
    var _cache_buffer = buffer_create(256, buffer_grow, 1);
    
    var _parser = new __input_bindings_read_parser(_buffer, buffer_get_size(_buffer), _cache_buffer);
    
    buffer_delete(_buffer);
    buffer_delete(_cache_buffer);
    
    var _config = _parser.root;
    
    if (_player_index == all)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            global.__input_players[_i].config = _config[_i];
            ++_i;
        }
    }
    else
    {
        global.__input_players[_player_index].config = _config;
    }
}

function __input_bindings_read_parser(_buffer, _buffer_size, _cache_buffer) constructor
{
    buffer          = _buffer;
    buffer_size     = _buffer_size;
    
    cache_buffer    = _cache_buffer;
    cache_started   = false;
    cache_value     = undefined;
    
    root            = undefined;
    root_is_struct  = false;
    root_array_size = 0;
    
    in_string       = false;
    escaped         = false;
    was_string      = false;
    
    in_key          = false;
    key             = undefined;
    
    
    
    static push_cache = function()
    {
        if (cache_value == undefined)
        {
            if (!cache_started)
            {
                show_error("Trying to read cache but there's nothing there (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
            }
            else
            {
                buffer_write(cache_buffer, buffer_u8, 0); //Make sure we definitely have a null terminating byte
                cache_value = buffer_peek(cache_buffer, 0, buffer_string);
                
                if (!was_string)
                {
                    switch(cache_value)
                    {
                        case "true":  cache_value = true;      break;
                        case "false": cache_value = false;     break;
                        case "null":  cache_value = undefined; break;
                        
                        default:
                            try
                            {
                                cache_value = real(cache_value);
                            }
                            catch(_error)
                            {
                                show_error("\"" + string(cache_value) + "\" could not be interpreted (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                            }
                        break;
                    }
                }
            }
        }
        
        if (root_is_struct)
        {
            if (in_key)
            {
                key = cache_value;
                in_key = false;
            }
            else
            {
                variable_struct_set(root, key, cache_value);
                in_key = true;
            }
        }
        else
        {
            root[@ root_array_size++] = cache_value;
        }
        
        buffer_seek(cache_buffer, buffer_seek_start, 0);
        cache_started = false;
        cache_value   = undefined;
        was_string    = false;
    };
    
    
    
    while(buffer_tell(buffer) < buffer_size)
    {
        value = buffer_read(buffer, buffer_u8);
        
        if (value == ord("\""))
        {
            if (root != undefined)
            {
                if (in_string)
                {
                    if (escaped)
                    {
                        buffer_write(cache_buffer, buffer_u8, value);
                        escaped = false;
                    }
                    else
                    {
                        in_string = false;
                    }
                }
                else
                {
                    cache_started = true;
                    in_string     = true;
                    was_string    = true;
                }
            }
            else
            {
                show_error("Quote mark found outside of an object or array (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
            }
        }
        else if (in_string)
        {
            if (escaped)
            {
                switch(value)
                {
                    case ord("n"): buffer_write(cache_buffer, buffer_u8, ord("\n")); break;
                    case ord("r"): buffer_write(cache_buffer, buffer_u8, ord("\r")); break;
                    case ord("t"): buffer_write(cache_buffer, buffer_u8, ord("\t")); break;
                    
                    default: 
                        buffer_write(cache_buffer, buffer_u8, value);
                    break;
                }
                
                escaped = false;
            }
            else if (value == ord("\\"))
            {
                escaped = true;
            }
            else
            {
                buffer_write(cache_buffer, buffer_u8, value);
            }
        }
        else
        {
            switch(value)
            {
                case ord(":"):
                    if (root_is_struct)
                    {
                        if (in_key)
                        {
                            push_cache();
                        }
                        else
                        {
                            show_error("\":\" found outside key (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                        }
                    }
                    else
                    {
                        show_error("\":\" found outside an object (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                    }
                break;
                
                case ord(","):
                    if (cache_started)
                    {
                        push_cache();
                    }
                    else
                    {
                        show_error("\",\" unexpected (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                    }
                    
                    in_key = root_is_struct;
                break;
                
                case ord("["):
                    if (root == undefined)
                    {
                        root = [];
                    }
                    else if (!in_key)
                    {
                        buffer_seek(buffer, buffer_seek_relative, -1);
                        cache_started = true;
                        cache_value = (new __input_bindings_read_parser(buffer, buffer_size, cache_buffer)).root;
                    }
                    else
                    {
                        show_error("\"[\" unexpected (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                    }
                break;
                
                case ord("{"):
                    if (root == undefined)
                    {
                        root           = {};
                        root_is_struct = true;
                        in_key         = true;
                    }
                    else if (!in_key)
                    {
                        buffer_seek(buffer, buffer_seek_relative, -1);
                        cache_started = true;
                        cache_value = (new __input_bindings_read_parser(buffer, buffer_size, cache_buffer)).root;
                    }
                    else
                    {
                        show_error("\"{\" unexpected (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                    }
                break;
                
                case ord("]"):
                case ord("}"):
                    if (cache_started) push_cache();
                    exit;
                break;
                
                default:
                    if (value > 32) //Not a whitespace character
                    {
                        if (root == undefined)
                        {
                            show_error("\"" + chr(value) + "\" found outside of an object or array (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                        }
                        else
                        {
                            buffer_write(cache_buffer, buffer_u8, value);
                            cache_started = true;
                        }
                    }
                break;
            }
        }
    }
}