/// @ignore
function __input_gm_runtime_version() {
    static _version = undefined;
    
    if (_version != undefined) return _version;
    
    var _pos = 1;
    var _version_str = GM_runtime_version; 
    var _number_str = undefined;
    _version = {
        major: 0,
        minor: 0,
        bug_fix: 0,
        build_number: 0
    };
    
    //Using the most appropriate methods in order to maximize compatibility down to 2.3.0
    _pos = string_pos(".", _version_str);
    _number_str = string_copy(_version_str, 1, _pos-1);
    if (string_length(string_digits(_number_str)) > 0) {
        _version.major = real(_number_str);	 
    }
    _version_str = string_delete(_version_str, 1, _pos);
    
    _pos = string_pos(".", _version_str);
    _number_str = string_copy(_version_str, 1, _pos-1);
    if (string_length(string_digits(_number_str)) > 0) {
        _version.minor = real(_number_str);
    }
    _version_str = string_delete(_version_str, 1, _pos);
    
    _pos = string_pos(".", _version_str);
    _number_str = string_copy(_version_str, 1, _pos-1);
    if (string_length(string_digits(_number_str)) > 0) {
        _version.bug_fix = real(_number_str);	 
    }
    _version_str = string_delete(_version_str, 1, _pos);
     
    _number_str = string_copy(_version_str, 1, _pos-1);
    if (string_length(string_digits(_number_str)) > 0) {
        _version.build_number = real(_number_str);	 
    }

    return _version;
}