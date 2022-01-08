
//get list of all open image windows
titles = getList("image.titles");

for (i=0; i<titles.length; i++){
		selectWindow(titles[i]);
		name = getTitle();
		dotIndex = indexOf(name, ".");
		nameWithoutExtension =  substring(name, 0, dotIndex);
		
		//run("Properties...", "channels=2 slices=1 frames=150 pixel_width=0.2661449 pixel_height=0.2661449 voxel_depth=0.5000000 frame=5");
		Stack.setDisplayMode("composite");
		Stack.setChannel(1);
		run("Green");
		run("Enhance Contrast", "saturated=0.15");
		Stack.setChannel(2);
		run("Magenta");
		run("Enhance Contrast", "saturated=0.15");

		run("Save");	
		//close();

}
