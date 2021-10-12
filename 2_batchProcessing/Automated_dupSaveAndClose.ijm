
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	startingFrame = 1;
	endingFrame = 50;
	newFileName = fileNameWithoutExtension + "-wGBD.tif" ;
	run("Duplicate...", "duplicate channels=1");
	saveAs("Tiff","/Volumes/FlashSSD/201124_Live_Flvw_Aegg_GFP-wGBD_Utr647_Cdc42N17_RacN17/201124_onlyGBD/"+newFileName);
	close();
	close();	
					}



