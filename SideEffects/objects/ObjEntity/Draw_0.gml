for(var i=0; i<num_components; i++)
{
	if(components[i].ComponentOnDraw == -1)
		continue;
	components[i].ComponentOnDraw();
}