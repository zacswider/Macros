
while (nImages > 0) {

	path = "/Users/bementmbp/Desktop/BementLab/2_Projects/23_DevPaper/Figures/Figure5A/210901_waveSizeAnalysis/5_smallCrop/";

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_Crop.tif" ;

	
	waitForUser("Please make a selection now");
	run("Crop");	
	saveAs("Tiff",path+newFileName);
	close();
	
					}