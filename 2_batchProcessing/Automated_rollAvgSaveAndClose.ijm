while (nImages > 0) {
	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_volCorr.tif" ;
	run("Running ZProjector2", "project=3 projection=[Average Intensity]");
	run("Enhance Contrast", "saturated=0.15");
	setSlice(25);
	run("Delete Slice");
	savePath = "/Users/bementmbp/Desktop/BementLab/2_Projects/29_tripleWavePaper/Figures/Figure01/tripleWaves/200200-201200_singleLabels_data/GFP/0_bleachCorr_rollAvg3-GFP";
	saveAs("Tiff", savePath + newFileName);
	close();
	close();
					}