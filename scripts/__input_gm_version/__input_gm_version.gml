/// @ignore
function __input_gm_version() {
	static _version = undefined;
	if (_version == undefined) 
    {
        var _version = {
            major: 0,
            minor: 0,
            bug_fix: 0,
            build_number: 0
        };
        
        // Using the most approriate methods in order to maximize compatiability down to 2.3.0
        var _version_str = GM_runtime_version;
        var _pos = string_pos(".", _version_str);
        _version.major = real(string_copy(_version_str, 1, _pos-1));
        _version_str = string_delete(_version_str, 1, _pos);
        
        _pos = string_pos(".", _version_str);
        _version.minor = real(string_copy(_version_str, 1, _pos-1));
        _version_str = string_delete(_version_str, 1, _pos);
        
        _pos = string_pos(".", _version_str);
        _version.bug_fix = real(string_copy(_version_str, 1, _pos-1));
        _version_str = string_delete(_version_str, 1, _pos);
        
        _version.build_number = real(string_copy(_version_str, 1, string_length(_version_str)));
    }
    return _version;
}