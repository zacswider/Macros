/*
 * Macro template to process multiple images in a folder
 */

#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix

processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(endsWith(list[i], suffix))
			processFile(input, output, list[i]);
	}
}

function processFile(input, output, file) {
	print("Processing " + file);
	run("Bio-Formats", "open=" + input + File.separator + file + " color_mode=Grayscale concatenate_series open_all_series display_rois rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	selectWindow(file + " - Series 1");

	fileName = getInfo("image.filename") ;  //saves image name for future use
	dotIndex = indexOf(fileName, ".");  	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); //this and the above line get the file name without the extension
	
	run("Z Project...", "projection=[Max Intensity] all");
	Stack.setChannel(1)
	roiManager("Select", 0);
	run("Clear Results");
	run("Plot Z-axis Profile");
	Plot.getValues(x, stim_ch1);
	close();
	Stack.setChannel(2);
	run("Clear Results");
	run("Plot Z-axis Profile");
	Plot.getValues(x, stim_ch2);
	close();
	Stack.setChannel(1);
	waitForUser(" ", "Move the ROI to a control region");
	roiManager("Select", 0);
	run("Clear Results");
	run("Plot Z-axis Profile");
	Plot.getValues(x, cntrl_ch1);
	close();
	Stack.setChannel(2);
	run("Clear Results");
	run("Plot Z-axis Profile");
	Plot.getValues(x, cntrl_ch2);
	close();
	Array.show("multichannel technical analysis oohhhhhh", stim_ch1, stim_ch2, cntrl_ch1, cntrl_ch2);
	print("Saving to: " + output);
	saveAs("Results", output + "/" + fileNameWithoutExtension + ".csv");
	run("Close");
	roiManager("delete");
	run("Close All");

}

