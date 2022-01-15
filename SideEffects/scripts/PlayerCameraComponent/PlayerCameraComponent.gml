function PlayerCameraComponent() : Component("PLAYER_CAMERA") constructor
{
	static ComponentOnPostUpdate = function()
	{
		var _camera_x = entity.x - 160;
		var _camera_y = entity.y - 90;
		_camera_x = clamp(_camera_x,0,global.WORLD.width*TILE_SIZE-320);
		_camera_y = clamp(_camera_y,0,global.WORLD.height*TILE_SIZE-180);
		camera_set_view_pos(view_camera[0],_camera_x,_camera_y);
	}
}