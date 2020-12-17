
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_GFPmCh.tif" ;
	Stack.setChannel(3);
	run("Delete Slice", "delete=channel");
	//Stack.setDisplayMode("composite");
	//run("Restore Selection");
	//run("Duplicate...", "title=" + newFileName + " duplicate");
	saveAs("Tiff","/Volumes/FlashSSD/201215_Live_SFC_Aegg_GFP-rGBD_mCh_iRFP-Utr/0_Analysis_reg/CropRegCrop_GFPmCh/"+newFileName);
	close();	
					}



