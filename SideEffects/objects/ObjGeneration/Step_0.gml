grid_getter.GridGetterUpdate();
if(grid_getter.complete)
{
	global.WORLD = new World(grid_getter.grids[0],grid_getter.grids[1]);
	room_goto(RoomMain);
}