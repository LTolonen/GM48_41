/// @function Component
/// @param component_type
function Component(_component_type) constructor
{
	component_type = _component_type;
	
	static ComponentOnPreUpdate = -1;
	static ComponentOnUpdate = -1;
	static ComponentOnPostUpdate = -1;
	static ComponentOnDraw = -1;
	static ComponentOnDestroy = -1;
}