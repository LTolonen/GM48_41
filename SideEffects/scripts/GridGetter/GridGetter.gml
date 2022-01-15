/// @function GridGetter
function GridGetter() constructor
{
	num_grids = 0;
	input_grids = array_create(0);
	grids = array_create(0);
	
	total_cells = 0;
	cells_calculated = 0;
	
	grid_index = 0;
	current_x = -1;
	current_y = -1;
	complete = true;
	
	frame_count = 0;
	
	/// @function GridGetterAddInputGrid
	/// @param grid
	static GridGetterAddInputGrid = function(_grid)
	{
		input_grids[num_grids++] = _grid;	
		total_cells += _grid.width * _grid.height;
		complete = false;
	}
	
	/// @function GridGetterUpdate
	static GridGetterUpdate = function()
	{
		if(complete)
			return;
			
		frame_count++;
			
		var t0 = current_time;
		do
		{
			var _is_done = GridGetterGetNextCell();
			t1 = current_time;
		}
		until(_is_done || t1-t0 > 5);
		
		show_debug_message("Progress: "+string(cells_calculated)+"/"+string(total_cells)+" cells ("+string(cells_calculated/total_cells*100)+"%)");
		
		if(_is_done)
		{
			complete = true;
			show_debug_message("Grid retrieval took "+string(frame_count)+" frames");
		}	
	}
	
	/// @function GridGetterGetNextCell
	static GridGetterGetNextCell = function()
	{
		var _current_grid = input_grids[grid_index];
		if(current_x == -1)
		{
			//Initialise
			current_x = 0;
			current_y = 0;
			grids[grid_index] = array_create(_current_grid.width);
			for(var i=0; i<_current_grid.width; i++)
			{
				grids[grid_index][i] = array_create(_current_grid.height);
			}
		}
		
		grids[grid_index][current_x][current_y] = input_grids[grid_index].FractalNoiseGetValue(current_x,current_y);
		cells_calculated += 1;
		
		current_x++;
		if(current_x >= _current_grid.width)
		{
			current_x = 0;
			current_y++;
			if(current_y >= _current_grid.height)
			{
				grid_index++;
				current_x = -1;
				current_y = -1;
				if(grid_index >= num_grids)
				{
					return true
				}
			}
		}
		return false;
	}
	
	/// @function GridGetterGetProgress
	static GridGetterGetProgress = function()
	{
		return cells_calculated / total_cells;	
	}
}