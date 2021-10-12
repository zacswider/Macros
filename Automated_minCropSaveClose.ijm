
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "Crop.tif" ;

	run("Z Project...", "projection=[Min Intensity]");run("Select All");
	run("Enhance Contrast", "saturated=0.35");
	waitForUser("Select Area", "Please make a selection now.");
	run("ROI Manager...");
	roiManager("Add");
	close();
	roiManager("Select", 0);
	run("Crop");
	saveAs("Tiff","/Volumes/FlashSSD/210212_Live_SFC_Aegg_GFP-wGBD_mCh-Utr_GAP1i_GAP17i/0_analysis/regCrop/"+newFileName);
	close();
	roiManager("Delete");
	
					}