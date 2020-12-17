while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "Crop.tif" ;
	
	run("Z Project...", "projection=[Min Intensity]");
	selectWindow("MIN_" + fileName);
	
	run("Z Project...", "projection=[Max Intensity]");
	selectWindow("MAX_MIN_" + fileName);
	
	setThreshold(1, 65535);
	run("Convert to Mask");
	run("Analyze Particles...", "add");
	selectWindow(fileName);
	roiManager("Select", 0);
	run("Crop");
	saveAs("Tiff","/Volumes/FlashSSD/201215_Live_SFC_Aegg_GFP-rGBD_mCh_iRFP-Utr/0_Analysis_reg/CropRegCrop/"+newFileName);
	close();
	
	selectWindow("MIN_" + fileName);
	close();
	selectWindow("MAX_MIN_" + fileName);
	close();
	
	roiManager("Delete");
	
					}


