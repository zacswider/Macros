

while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	path = getDirectory("image") ;
	//saves path that the image is saved to
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_Gauss8AutoThresh.tif" ;

	run("Gaussian Blur...", "sigma=8 stack");
	setAutoThreshold("Default");
	//run("Threshold...");
	setOption("BlackBackground", false);
	run("Convert to Mask", "method=Default background=Light calculate");
	
	saveAs("Tiff","/Users/bementmbp/Desktop/210603_Live_SFC_Emb_Utr647/"+newFileName);
	close();
	
					}


