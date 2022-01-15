grid_getter.GridGetterUpdate();
if(grid_getter.complete)
{
	global.WORLD = new World(grid_getter.grids[0]);
	room_goto(RoomMain);
}