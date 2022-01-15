// Inherit the parent event
event_inherited();

width = 8;
height = 8;
player_control_component = entity_add_component(self,new PlayerControlComponent());
physics_component = entity_add_component(self,new PhysicsComponent(0.25,0.5,0.5));
player_camera_component = entity_add_component(self,new PlayerCameraComponent());
sprite_component = entity_add_component(self,new SpriteComponent());