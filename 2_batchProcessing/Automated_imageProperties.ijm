percentSaturation = 0.15 ;
colors_twoChannel = newArray("Green", "Magenta");
colors_threeChannel = newArray("Cyan", "Magenta", "Yellow");
colors_fourChannel = newArray("Green", "Magenta", "Yellow", "Cyan");
colors_fiveChannel  = newArray("Green", "Magenta", "Yellow", "Cyan", "Grays");

titles = getList("image.titles");	// sets titles equal to an array containing all of the image names that are curently open
for (y=0; y<titles.length; y++){    // one trip through the loop for every open image
	selectWindow(titles[y]);		// selects an image
	getDimensions(width, height, channels, slices, frames);
	// sets the variables in parentheses equal to the properties of the active image
	
	if (channels == 2) {			// runs through the usual logic, contrast setting, and LUT applying
		makePretty(colors_twoChannel);
	}
	if (channels == 3) {
		makePretty(colors_threeChannel);
	}
	if (channels == 4) {
		makePretty(colors_fourChannel);
	}
	if (channels == 5) {
		makePretty(colors_fiveChannel);
	}
	}
	
	run("Save");

function makePretty (LUT_Array) {
	Stack.setDisplayMode("composite");
	for (i=0; i<LUT_Array.length; i++) {
		Stack.setChannel(i+1);
		run("Enhance Contrast", "saturated=" + percentSaturation);
		run(LUT_Array[i]);
	}
}


