for(var i=0; i<num_components; i++)
{
	if(components[i].ComponentOnPreUpdate == -1)
		continue;
	components[i].ComponentOnPreUpdate();
}