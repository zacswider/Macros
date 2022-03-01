frames_to_project = 3

while (nImages > 0) {
	
	
	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dir = getInfo("image.directory");
	dir = "/Users/bementmbp/Desktop/BementLab/2_Projects/29_tripleWavePaper/Figures/Figure01/tripleWaves/201022_dualLabels_data/0_bleachCorr_rollAvg/";
	//directory that the image was loaded from
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_rollAvg" + frames_to_project + ".tif" ;
	
	getDimensions(width, height, channels, slices, frames);
	run("Split Channels");
	
	for (i=1; i<=channels; i++) {
		selectWindow("C" + i + "-" + fileName);
		run("Running ZProjector2", "project=" + frames_to_project + " projection=[Average Intensity]");
		selectWindow("C" + i + "-" + fileName);
		close();
	}
	
	run("Merge Channels...", "c1=[C1-" + fileName + ":Group size = " + frames_to_project + ".] c2=[C2-" + fileName + ":Group size = " + frames_to_project + ".] c3=[C3-" + fileName + ":Group size = " + frames_to_project + ".] create ignore");// c4=[C4-" + fileName + ":Group size = " + frames_to_project + ".] create ignore");
	
	Stack.setDisplayMode("composite");
	run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");
	saveAs("Tiff", dir + newFileName);
	close();
	

	
}

