/// @function WorldCell
/// @param material
/// @param cell_x
/// @param cell_y
function WorldCell(_material, _cell_x, _cell_y) constructor
{
	material = _material;
	cell_x = _cell_x;
	cell_y = _cell_y;
	
	x = cell_x*TILE_SIZE;
	y = cell_y*TILE_SIZE;
	left_x = x;
	right_x = x+TILE_SIZE;
	top_y = y;
	bottom_y = y+TILE_SIZE;
	damage = 0;
	
	is_solid = global.MATERIAL_IS_SOLID[_material];
	
	/// @function WorldCellUpdate
	static WorldCellUpdate = function()
	{
		if(material == MATERIAL.FUNGUS)
		{
			if(random(1000) < 1)
			{
				var d = irandom(3)*90;
				var _nx = cell_x+lengthdir_x(1,d);
				var _ny = cell_y+lengthdir_y(1,d);
				if(global.WORLD.grid[_nx,_ny].material == MATERIAL.AIR)
				{
					global.WORLD.grid[_nx,_ny] = new WorldCell(MATERIAL.FUNGUS,_nx,_ny);
				}
			}
		} 
	}
	
	/// @function WorldCellDraw
	static WorldCellDraw = function()
	{
		var _spr = global.MATERIAL_SPRITE[material]
		if(_spr == -1)
			return;
		draw_sprite(_spr,0,x,y,);
		if(damage > 0)
		{
			var _damage_frame = damage / global.MATERIAL_HEALTH[material] * (sprite_get_number(SprBlockDamage)-1);
			draw_sprite(SprBlockDamage,_damage_frame,x,y);
		}
	}
	
	/// @function WorldCellDamage
	/// @param amount
	static WorldCellDamage = function(_amount)
	{
		if(global.MATERIAL_HEALTH[material] == -1)
			return;
		damage += _amount;
		if(damage > global.MATERIAL_HEALTH[material])
		{
			global.WORLD.WorldDestroyCell(cell_x,cell_y);	
		}
	}
}