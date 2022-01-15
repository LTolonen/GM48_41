for(var i=0; i<num_components; i++)
{
	if(components[i].ComponentOnUpdate == -1)
		continue;
	components[i].ComponentOnUpdate();
}