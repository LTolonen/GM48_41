for(var i=0; i<num_components; i++)
{
	if(components[i].ComponentOnPostUpdate == -1)
		continue;
	components[i].ComponentOnPostUpdate();
}