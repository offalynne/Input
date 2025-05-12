// Feather disable all

function __InputTextHandleChanges()
{
    static _textChanges = [];
            
    if (__textAsync != undefined)
    {
        __textRequest = __textAsync;
        __textAsync   = undefined;
        __textSet     = undefined;
    }
    else if (__textSet != undefined)
    {
        __textRequest = __textSet;
        __textSet     = undefined;    
    }
    else
    {
        if ((__newStatus == undefined) && (__requestStatus == INPUT_TEXT_STATUS.WAITING) && (array_length(_textChanges) == 0))
        {
            if (__removeCount > 0) array_push(_textChanges, __removeCount);
            if (string_length(__textDelta)) array_push(_textChanges, __textDelta);
        }

        var _i = 0;
        repeat(array_length(_textChanges))
        {
            var _value = _textChanges[_i];
            if (is_string(_value))
            {
                __textRequest += _value;
            }
            else if (is_real(_value))
            {
                __textRequest = string_copy(__textRequest, 1, max(0, string_length(__textRequest) - _value));
            }
                
            ++_i;
        }
            
        array_resize(_textChanges, 0);            
        __textRequest = string_copy(__textRequest, 1, __maxLength);
    }
}