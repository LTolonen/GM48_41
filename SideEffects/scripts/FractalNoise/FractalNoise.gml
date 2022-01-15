/// @function FractalNoise
/// @param width
/// @param height
/// @param num_octaves
/// @param [skip_levels]
function FractalNoise(_width, _height, _num_octaves,_skip_levels=0) constructor
{
	width = _width;
	height = _height;
	num_octaves = _num_octaves;
	skip_levels = _skip_levels;
	octaves = array_create(num_octaves,undefined);
	for(var i=0; i<num_octaves; i++)
	{
		FractalNoiseGenerateOctave(i);	
	}
	
	/// @function FractalNoiseGenerateOctave
	/// @param octave_index
	static FractalNoiseGenerateOctave = function(_octave_index)
	{
		var w = ceil(width / power(2,_octave_index+skip_levels));
		var h = ceil(height / power(2,_octave_index+skip_levels));
		octaves[_octave_index] = new PerlinNoise(w,h);
		return octaves[_octave_index];
	}
	
	/// @function FractalNoiseGetValue
	/// @param x
	/// @param y
	static FractalNoiseGetValue = function(_x,_y)
	{
		var v = 0;
		for(var i=0; i<num_octaves; i++)
		{
			var w = 1 / power(2,num_octaves-1-i);
			var _sample_x = _x / power(2,i+skip_levels);
			var _sample_y = _y / power(2,i+skip_levels);
			v += w*octaves[i].PerlinNoiseGetValue(_sample_x,_sample_y);
		}
		return v;
	}
	
	/// @function FractNoiseGetGrid
	static FractalNoiseGetGrid = function()
	{
		var _grid = array_create(width);
		for(var i=0; i<width; i++)
		{
			_grid[i] = array_create(height);
			for(var j=0; j<height; j++)
			{
				_grid[i][j] = FractalNoiseGetValue(i,j);	
			}
		}
		return _grid;
	}
}