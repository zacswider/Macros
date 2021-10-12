
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_wGBD.tif" ;
	Stack.setChannel(2);
	run("Delete Slice", "delete=channel");

	
	//run("Split Channels");
	//run("Merge Channels...", "c1=C2-"+fileNameWithoutExtension+".tif c2=C1-"+fileNameWithoutExtension+".tif create");
	//Stack.setDisplayMode("grayscale");
	
	saveAs("Tiff","/Users/bementmbp/Desktop/RNAi test wgbd/"+newFileName);
	close();	
					}



