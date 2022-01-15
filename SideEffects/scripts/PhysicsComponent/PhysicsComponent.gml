/// @functionn PhysicsComponent
/// @param [gravity]
/// @param [ground_friction]
/// @param [air_friction]
function PhysicsComponent(_gravity = 0, _ground_friction = 0, _air_friction = 0) : Component("PHYSICS") constructor
{
	gravity = _gravity;
	ground_friction = _ground_friction;
	air_friction = _air_friction;
	on_ground = false;
	frames_since_last_ground = 0;
	xspeed = 0;
	yspeed = 0;
	
	terminal_velocity = 8;
	
	static ComponentOnUpdate = function()
	{
		world = global.WORLD;
		if(world.WorldCollisionSolidRectangle(entity.x,entity.y+entity.height,entity.width,1))
		{
			on_ground = true;
			frames_since_last_ground = 0;
		}
		else
		{
			on_ground = false;
			frames_since_last_ground++;
			yspeed += gravity;
			yspeed = min(yspeed,terminal_velocity);
		}
		
		//Friction
		var _friction = ground_friction;
		if(!on_ground)
			_friction = air_friction;
		if(abs(xspeed) <= _friction)
		{
			xspeed = 0;	
		}
		else
		{
			xspeed -= sign(xspeed)*_friction;	
		}
		
		//Movement
		if(xspeed > 0) //Moving right
		{
			var _solids = world.WorldGetSolidsInRectangle(entity.x+entity.width,entity.y,xspeed,entity.height);
			if(array_length(_solids) > 0)
			{
				var _min_left_x = entity.x+entity.width+xspeed;
				for(var i=0; i<array_length(_solids); i++)
				{
					_min_left_x = min(_min_left_x,_solids[i].left_x);
				}
				entity.x = _min_left_x-entity.width;//max(entity.x,_min_left_x-entity.width);
				xspeed = 0;
			}
			else
				entity.x += xspeed;
		}
		else if(xspeed < 0) //Moving left
		{
			var _solids = world.WorldGetSolidsInRectangle(entity.x+xspeed,entity.y,-xspeed,entity.height);
			if(array_length(_solids) > 0)
			{
				var _max_right_x = entity.x+xspeed;
				for(var i=0; i<array_length(_solids); i++)
				{
					_max_right_x = max(_max_right_x,_solids[i].right_x);
				}
				entity.x = min(entity.x,_max_right_x);
				xspeed = 0;
			}
			else
				entity.x += xspeed;
		}
		if(yspeed > 0) //Moving down
		{
			var _solids = world.WorldGetSolidsInRectangle(entity.x,entity.y+entity.height,entity.width,yspeed);
			if(array_length(_solids) > 0)
			{
				var _min_top_y = entity.y+entity.height+yspeed;
				for(var i=0; i<array_length(_solids); i++)
				{
					_min_top_y = min(_min_top_y,_solids[i].top_y);
				}
				//entity.y = max(entity.y,_min_top_y-entity.height);
				entity.y = _min_top_y-entity.height;
				yspeed = 0;
			}
			else
				entity.y += yspeed;
		}
		else if(yspeed < 0) //Moving up
		{
			var _solids = world.WorldGetSolidsInRectangle(entity.x,entity.y+yspeed,entity.width,-yspeed);
			if(array_length(_solids) > 0)
			{
				var _max_bottom_y = entity.y+yspeed;
				for(var i=0; i<array_length(_solids); i++)
				{
					_max_bottom_y = max(_max_bottom_y,_solids[i].bottom_y);
				}
				entity.y = min(entity.y,_max_bottom_y);
				yspeed = 0;
			}
			else
				entity.y += yspeed;
		}
	}
}