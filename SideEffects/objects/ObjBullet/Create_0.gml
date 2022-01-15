// Inherit the parent event
event_inherited();

width = 6;
height = 6;
physics_component = entity_add_component(self,new PhysicsComponent());
physics_component.PhysicsComponentOnSolidCollision = function(_collision_solid)
{
	_collision_solid.WorldCellDamage(1);
	instance_destroy();	
}

sprite_component = entity_add_component(self,new SpriteComponent());

