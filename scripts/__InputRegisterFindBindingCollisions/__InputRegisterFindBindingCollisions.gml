// Feather disable all

function __InputRegisterFindBindingCollisions()
{
    __InputPlugInRegisterCallbackInternal(INPUT_PLUG_IN_CALLBACK.FIND_BINDING_COLLISIONS, 0, function(_collisionArray, _forGamepad, _binding, _verbIndex, _alternate, _playerIndex)
    {
        __InputBindingFindInternal(_collisionArray, _forGamepad, _binding, _playerIndex); 
    });
}