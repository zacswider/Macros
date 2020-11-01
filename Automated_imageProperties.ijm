
while (nImages > 0) {

	run("Properties...", "unit=micron pixel_width=0.2661448 pixel_height=0.2661448 voxel_depth=0.5 frame=3.5");
	Stack.setDisplayMode("composite");
	Stack.setChannel(1);
	run("Green");
	resetMinAndMax();
	Stack.setChannel(2);
	run("Magenta");
	resetMinAndMax();
	//Stack.setChannel(3);
	//run("Grays");
	//resetMinAndMax();
	//Stack.setChannel(4);
	//run("Grays");
	//resetMinAndMax();
	//Stack.setActiveChannels("101");
	run("Save");
	close();
	
					}