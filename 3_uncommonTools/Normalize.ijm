
fileName = getInfo("image.title") ; 	
getDimensions(width, height, channels, slices, frames);
run("32-bit");
run("Split Channels");

for (i = 1; i <= channels; i++) {

	selectWindow("C" + i + "-" + fileName);
	run("Z Project...", "projection=[Min Intensity]");
	selectWindow("MIN_C" + i + "-" + fileName);
	run("Set Measurements...", "mean min redirect=None decimal=3");
	run("Measure");
	mean_min = getResult("Mean", 0);
	run("Clear Results");
	close("MIN_C" + i + "-" + fileName);
	selectWindow("C" + i + "-" + fileName);
	run("Z Project...", "projection=[Max Intensity]");
	selectWindow("MAX_C" + i + "-" + fileName);
	run("Measure");
	mean_max = getResult("Mean", 0);
	run("Clear Results");
	close("MAX_C" + i + "-" + fileName);
	correction_factor = mean_max - mean_min ;
	selectWindow("C" + i + "-" + fileName);
	run("Subtract...", "value=" + mean_min + " stack");
	run("Divide...", "value=" + correction_factor + " stack");
	rename("ch" + i);
}


percentSaturation = 0.15 ;	// sets percentSaturation variable equal to some number >0 and < 100
colors_twoChannel = newArray("Green", "Magenta");
colors_threeChannel = newArray("Cyan", "Magenta", "Yellow");
colors_fourChannel = newArray("Cyan", "Magenta", "Yellow", "Grays");
colors_fiveChannel  = newArray("Green", "Magenta", "Yellow", "Cyan", "Grays");
// these arrays contain two, three, four, or five LUT names

if (channels == 2) {	// if the active image has two channels...

	run("Merge Channels...", 
	"c1=ch1 c2=ch2 create");
	
	makePretty(colors_twoChannel); // calls the "makePretty" function and sends it to the twoChannel color array as an input variable
}
if (channels == 3) {	// if the active image has three channels...
	
	run("Merge Channels...", 
	"c1=ch1 c2=ch2 c3=ch3 create");
	
	makePretty(colors_threeChannel); // calls the "makePretty" function and sends it to the threeChannel color array as an input variable
}
if (channels == 4) {	// if the active image has four channels...
	
	run("Merge Channels...", 
	"c1=ch1 c2=ch2 c3=ch3 c4=ch4 create");
	
	makePretty(colors_fourChannel); // calls the "makePretty" function and sends it to the fourChannel color array as an input variable
}
if (channels == 5) {	// if the active image has five channels...
	
	run("Merge Channels...", 
	"c1=ch1 c2=ch2 c3=ch3 c4=ch4 c5=ch5 create");
	
	makePretty(colors_fiveChannel); // calls the "makePretty" function and sends it to the fiveChannel color array as an input variable
}

function makePretty (LUT_Array) {			// take one input variable: LUT_Array
	Stack.setDisplayMode("composite");		// sets the display mode to composite
	for (i=0; i<LUT_Array.length; i++) {	// one trip through the loop for every item in the LUT array
		Stack.setChannel(i+1);
		run("Enhance Contrast", "saturated=" + percentSaturation);
		run(LUT_Array[i]);
}


