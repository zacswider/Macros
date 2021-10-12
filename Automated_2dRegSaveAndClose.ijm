
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	path = getDirectory("image") ;
	//saves path that the image is saved to
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_Reg.tif" ;

	fullPath = path + "/" + newFileName;
	//creates a save path for the newly created file
	
	//makeRectangle(96, 28, 338, 462);
	//run("Crop");	

	run("StackReg ", "transformation=Translation");


	run("Enhance Contrast", "saturated=0.15");
	
	saveAs("Tiff","/Users/bementmbp/Desktop/BementLab/2_Projects/23_DevPaper/Figures/Figure5A/210901_waveSizeAnalysis/2_Reg/"+newFileName);	
	//save(fullPath) ;
	close();
	
					}