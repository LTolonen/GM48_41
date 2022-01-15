/// @function entity_add_component
/// @param obj
/// @param component
function entity_add_component(_obj,_component)
{
	with(_obj)
	{
		components[num_components++] = _component;
		_component.entity = _obj;
	}
	return _component;
}