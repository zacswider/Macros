
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	path = getDirectory("image") ;
	//saves path that the image is saved to
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_Crop.tif" ;

	fullPath = path + "/" + newFileName;
	//creates a save path for the newly created file
	
	makeRectangle(99, 24, 261, 481);
	run("Crop");	
	
	saveAs("Tiff","/Volumes/FlashSSD/201231_Live_SFC_Aegg_GFP-rGBD_mCh_Ect2/0_Analysis_Crop2/"+newFileName);	
	//save(fullPath) ;
	close();
	
					}