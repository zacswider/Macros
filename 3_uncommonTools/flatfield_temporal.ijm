

fileName = getInfo("image.filename") ; 
//saves image name for future use
dir = getInfo("image.directory");
//dir = "custom dir, if you want to save somewhere else";
//directory that the image was loaded from
dotIndex = indexOf(fileName, ".");  
//this and the following line get the file name without the extension
fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
//this and the above line get the file name without the extension
newFileName = fileNameWithoutExtension + "_ffCorr.tif" ;

getDimensions(width, height, channels, slices, frames);

for (i=1; i<=channels; i++) {
	selectWindow(fileName);
	run("Duplicate...", "title=ch" + i + " duplicate channels=" + i);
	run("Z Project...", "projection=[Average Intensity]");
	//run("Z Project...", "projection=[Min Intensity]");	// min intensity behaves differently but produces similar result
	imageCalculator("Divide create 32-bit stack", "ch" + i,"AVG_ch" + i);
	selectWindow("Result of ch" + i);
	close("AVG_ch" + i);
	close("ch" + i);
}

percentSaturation = 0.15 ;
colors_twoChannel = newArray("Green", "Magenta");
colors_threeChannel = newArray("Cyan", "Magenta", "Yellow");

if (channels == 2) {			// runs through the usual logic, contrast setting, and LUT applying
	run("Merge Channels...", "c1=[Result of ch1] c2=[Result of ch2] create ignore");
	makePretty(colors_twoChannel);
}
if (channels == 3) {
	run("Merge Channels...", "c1=[Result of ch1] c2=[Result of ch2] c3=[Result of ch3] create ignore");
	makePretty(colors_threeChannel);
}

function makePretty (LUT_Array) {
	Stack.setDisplayMode("composite");
	for (i=0; i<LUT_Array.length; i++) {
		Stack.setChannel(i+1);
		run("Enhance Contrast", "saturated=" + percentSaturation);
		run(LUT_Array[i]);
	}
}

saveAs("Tiff", dir + newFileName);