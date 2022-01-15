function SpriteComponent() : Component("SPRITE") constructor
{
	static ComponentOnDraw = function()
	{
		draw_sprite(entity.sprite_index,entity.image_index,entity.x,entity.y);	
	}
}