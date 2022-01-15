global.WORLD = -1;

#macro WORLD_WIDTH_TILES 180
#macro WORLD_HEIGHT_TILES 180
#macro TILE_SIZE 10

/// @function World
/// @param solid_grid
function World(_solid_grid) constructor
{
	width = array_length(_solid_grid);
	height = array_length(_solid_grid[0]);
	
	grid = array_create(width);
	for(var i=0; i<width; i++)
	{
		grid[i] = array_create(height);
		for(var j=0; j<height; j++)
		{
			if(i == 0 || j == 0 || i == width-1 || j == height-1)
				grid[i][j] = MATERIAL.STONE;
			else
			{
				var _ref_value = lerp(0.3,-0.3,j/height);
				grid[i][j] = _solid_grid[i][j] > _ref_value;
			}
				
		}
	}
	
	/// @function WorldDraw
	/// @param camera_x
	/// @param camera_y
	/// @param camera_width
	/// @param camera_height
	static WorldDraw = function(_camera_x, _camera_y, _camera_width, _camera_height)
	{
		var _cell_x0 = _camera_x div TILE_SIZE;
		var _cell_y0 = _camera_y div TILE_SIZE;
		var _cell_x1 = (_camera_x + _camera_width) div TILE_SIZE;
		var _cell_y1 = (_camera_y + _camera_height) div TILE_SIZE;
		
		draw_set_color(c_black);
		for(var _cell_x=_cell_x0; _cell_x<=_cell_x1; _cell_x++)
		{
			for(var _cell_y=_cell_y0; _cell_y<=_cell_y1; _cell_y++)
			{
				if(_cell_x < 0 || _cell_x >= width)
					continue;
				if(_cell_y < 0 || _cell_y >= height)
					continue;	
				var x0 = _cell_x*TILE_SIZE+1;
				var y0 = _cell_y*TILE_SIZE+1;
				var x1 = x0+TILE_SIZE-1;
				var y1 = y0+TILE_SIZE-1;
				if(grid[_cell_x][_cell_y] == MATERIAL.STONE)
				{
					draw_rectangle(x0,y0,x1,y1,false);	
				}
			}
		}
		draw_set_color(c_red);
		for(var _cell_x=_cell_x0; _cell_x<=_cell_x1; _cell_x++)
		{
			for(var _cell_y=_cell_y0; _cell_y<=_cell_y1; _cell_y++)
			{
				if(_cell_x < 0 || _cell_x >= width)
					continue;
				if(_cell_y < 0 || _cell_y >= height)
					continue;	
				var x0 = _cell_x*TILE_SIZE;
				var y0 = _cell_y*TILE_SIZE;
				var x1 = x0+TILE_SIZE-1;
				var y1 = y0+TILE_SIZE-1;
				if(grid[_cell_x][_cell_y] == MATERIAL.STONE)
				{
					draw_rectangle(x0,y0,x1,y1,false);	
				}
			}
		}
	}
	
	/// @function WorldCollisionSolidRectangle
	/// @param x
	/// @param y
	/// @param width
	/// @param height
	static WorldCollisionSolidRectangle = function(_x, _y, _width, _height)
	{
		var _cell_x0 = floor(_x / TILE_SIZE);
		var _cell_y0 = floor(_y / TILE_SIZE);
		var _cell_x1 = floor((_x + _width - 0.001) / TILE_SIZE);
		var _cell_y1 = floor((_y + _height - 0.001) / TILE_SIZE);
		for(var _cell_x=_cell_x0; _cell_x<=_cell_x1; _cell_x++)
		{
			if(_cell_x < 0 || _cell_x >= width)
				continue;
			for(var _cell_y=_cell_y0; _cell_y<=_cell_y1; _cell_y++)
			{
				if(_cell_y < 0 || _cell_y >= height)
					continue;
				var _material = grid[_cell_x][_cell_y];
				if(global.MATERIAL_IS_SOLID[_material])
					return true;
			}
		}
		return false;
	}
	
	
	/// @function WorldGetSolidsInRectangle
	/// @param x
	/// @param y
	/// @param width
	/// @param height
	static WorldGetSolidsInRectangle = function(_x, _y, _width, _height)
	{
		var _num_results = 0;
		var _results = array_create(0);
		var _cell_x0 = floor(_x / TILE_SIZE);
		var _cell_y0 = floor(_y / TILE_SIZE);
		var _cell_x1 = floor((_x + _width - 0.001) / TILE_SIZE);
		var _cell_y1 = floor((_y + _height - 0.001) / TILE_SIZE);
		for(var _cell_x=_cell_x0; _cell_x<=_cell_x1; _cell_x++)
		{
			if(_cell_x < 0 || _cell_x >= width)
				continue;
			for(var _cell_y=_cell_y0; _cell_y<=_cell_y1; _cell_y++)
			{
				if(_cell_y < 0 || _cell_y >= height)
					continue;
				var _material = grid[_cell_x][_cell_y];
				if(global.MATERIAL_IS_SOLID[_material])
				{
					_results[_num_results++] = new WorldCellData(self,_cell_x,_cell_y);
				}
			}
		}
		return _results;
	}
}