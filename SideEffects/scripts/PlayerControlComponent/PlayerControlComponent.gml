function PlayerControlComponent() : Component("PLAYER_CONTROL") constructor
{
	acceleration = 0.75;
	max_xspeed = 4;
	normal_gravity = 0.25;
	hold_gravity = normal_gravity / 2;
	
	jump_yspeed = -3;
	
	fuel_max = 60;
	fuel = 0;
	hovering = false;
	jetpack_acceleration = 0.25;
	jetpack_max_speed = 3;
	
	static ComponentOnPreUpdate = function()
	{
		var _right_left = keyboard_check(vk_right)-keyboard_check(vk_left);
		
		entity.physics_component.gravity = normal_gravity;
		entity.physics_component.xspeed = clamp(entity.physics_component.xspeed+acceleration*_right_left,-max_xspeed,max_xspeed);
		
		if(keyboard_check_pressed(vk_space))
		{
			if(entity.physics_component.frames_since_last_ground < 4)
			{
				entity.physics_component.yspeed = jump_yspeed;	
			}
			else if(fuel > 0)
			{
				hovering = true;	
			}
		}
		
		if(keyboard_check(vk_space))
		{
			if(entity.physics_component.yspeed < 0)
			{
				entity.physics_component.gravity = hold_gravity;	
			}
		}
		else
		{
			hovering = false;	
		}
		
		if(hovering)
		{
			entity.physics_component.gravity = 0;
			//if(entity.physics_component.yspeed > 0)
			//	entity.physics_component.yspeed = 0;
			//else
			{
				entity.physics_component.yspeed -= jetpack_acceleration;
				entity.physics_component.yspeed = max(-jetpack_max_speed,entity.physics_component.yspeed);
			}
			fuel--;
			if(fuel < 0)
				hovering = false;
		}
		
	}
	
	static ComponentOnUpdate = function()
	{
		if(entity.physics_component.on_ground)
		{
			fuel = fuel_max;
		}
	}
}