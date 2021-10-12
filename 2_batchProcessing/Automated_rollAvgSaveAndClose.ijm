while (nImages > 0) {
	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_volCorr.tif" ;
	run("Running ZProjector2", "project=2 projection=[Average Intensity]");
	run("Enhance Contrast", "saturated=0.15");
	setSlice(25);
	run("Delete Slice");
	saveAs("Tiff","/Volumes/FlashSSD/210618_Live_SFC_Aegg_BFP_GFP-pGBD_mCh-2XrGBD_iRFP-Utr/0_analysis/BFP-rGBD/3_BFP-rGBD-volCorr-noNorm-roll2/"+newFileName);
	close();
	close();
					}