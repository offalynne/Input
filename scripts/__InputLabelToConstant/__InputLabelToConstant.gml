function __InputLabelToConstant(_label)
{
    static _labelToConstantDict = __input_global().__labelToConstantDict;
    
    return _labelToConstantDict[$ _label];
}