titles = getList("image.titles");	// sets titles equal to an array containing all of the image names that are curently open
for (y=0; y<titles.length; y++){    // one trip through the loop for every open image
	selectWindow(titles[y]);		// selects an image
	Stack.setDisplayMode("grayscale");
	Stack.setChannel(2);
	run("Enhance Contrast", "saturated=0.15");
}