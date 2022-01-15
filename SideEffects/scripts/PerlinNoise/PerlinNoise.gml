/// @function PerlinNoise
/// @param width
/// @param height
function PerlinNoise(_width, _height) constructor
{
	width = _width;
	height = _height;
	
	//Generate gradients
	gradients = array_create(_width+1);
	for(var i=0; i<=_width; i++)
	{
		gradients[i] = array_create(_height+1);
		for(var j=0; j<=_height; j++)
		{
			var _angle = random(360);
			
			gradients[i][j] = {
				x: lengthdir_x(1,_angle),
				y: lengthdir_y(1,_angle)
			};
		}
	}

	/// @function PerlinNoiseGetValue
	/// @param x
	/// @param y
	static PerlinNoiseGetValue = function(_x, _y)
	{
		var _x0 = floor(_x);
		var _y0 = floor(_y);
		var _x1 = _x0+1;
		var _y1 = _y0+1;
		var _x_weight = _x - _x0;
		var _y_weight = _y - _y0;
		var _x0_value = lerp(PerlinNoiseGetDotValue(_x,_y,_x0,_y0),PerlinNoiseGetDotValue(_x,_y,_x0,_y1),_y_weight);
		var _x1_value = lerp(PerlinNoiseGetDotValue(_x,_y,_x1,_y0),PerlinNoiseGetDotValue(_x,_y,_x1,_y1),_y_weight);
		return lerp(_x0_value,_x1_value,_x_weight);
	}
	
	/// @function PerlinNoiseGetDotValue
	/// @param x
	/// @param y
	/// @param corner_x
	/// @param corner_y
	static PerlinNoiseGetDotValue = function(_x, _y, _corner_x, _corner_y)
	{
		var _dx = _x - _corner_x;
		var _dy = _y - _corner_y;
		var _gradient = gradients[_corner_x,_corner_y];
		return dot_product(_gradient.x,_gradient.y,_dx,_dy);
	}
}