/// @function WorldCellData
/// @param world
/// @param cell_x
/// @param cell_y
function WorldCellData(_world, _cell_x, _cell_y) constructor
{
	cell_x = _cell_x;
	cell_y = _cell_y;
	material = _world.grid[cell_x][cell_y];
	x = cell_x*TILE_SIZE;
	y = cell_y*TILE_SIZE;
	left_x = x;
	right_x = x+TILE_SIZE;
	top_y = y;
	bottom_y = y+TILE_SIZE;
}