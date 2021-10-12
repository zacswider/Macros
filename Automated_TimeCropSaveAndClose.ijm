//This macro creates difference movies from multi-channel movies
while (nImages > 0) {
	getDimensions(width, height, channels, slices, frames) ;		
	//gets and saves the movie dimensions for later use
	fileName = getInfo("image.title"); 
	//gets and saves the file name for later

	imageName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(imageName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(imageName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "Short.tif" ;

	startingFrame = 1;
	endingFrame = 10;
	run("Duplicate...", "title="+newFileName+" duplicate frames="+startingFrame+"-"+endingFrame);
	
	saveAs("Tiff","/Volumes/FlashSSD/210226_Live_SFC_Aegg_BFP_GFP-wGBD_mCh-2XrGBD_Utr647/0_dataAnalysis/regCropDiff2Short/"+newFileName);
	close() ;
	close() ;
					}