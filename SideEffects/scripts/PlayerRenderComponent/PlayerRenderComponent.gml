function PlayerRenderComponent() : Component("PLAYER_RENDER") constructor
{
	static ComponentOnDraw = function()
	{
		var _head_frame = 0;
		if(entity.player_control_component.vertical_facing == -1)
			_head_frame = 2;
		if(entity.player_control_component.vertical_facing == 1)
			_head_frame = 1;
		if(entity.player_control_component.facing_left)
		{
			draw_sprite_ext(entity.sprite_index,entity.image_index,entity.x+8,entity.y,-1,1,0,c_white,1);	
			draw_sprite_ext(SprPlayerHead,_head_frame,entity.x+8,entity.y,-1,1,0,c_white,1);	
		}
		else
		{
			draw_sprite(entity.sprite_index,entity.image_index,entity.x,entity.y);
			draw_sprite(SprPlayerHead,_head_frame,entity.x,entity.y);
		}
	}
}