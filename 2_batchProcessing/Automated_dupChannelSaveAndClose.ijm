
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_wGBD.tif" ;
	
	run("Duplicate...", "duplicate channels=2");

	run("Green");
	run("Enhance Contrast", "saturated=0.15");
	
	saveAs("Tiff","/Volumes/FlashSSD/210507_Live_SFC_Aegg_BFP_GFP-wGBD_mCh-2XrGBD_iRFP-Utr_MgcWT/0_analysis/wGBD/"+newFileName);
	close();
	close();	
					}



