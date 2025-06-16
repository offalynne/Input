// Feather disable all

function __InputOnOperaGXMobile()
{
  static _onOperaGXMobile = (function()
  {
    if (os_type != os_operagx) return false;
    
    var _map = os_get_info();
    var _onMobile = _map[? "mobile"];
    ds_map_destroy(_map);

    return _onMobile;
  })();

  return _onOperaGXMobile;
}
