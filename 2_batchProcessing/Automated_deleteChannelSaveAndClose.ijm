
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_norGBD.tif" ;
	Stack.setChannel(1);
	run("Delete Slice", "delete=channel");

	
	//run("Split Channels");
	//run("Merge Channels...", "c1=C2-"+fileNameWithoutExtension+".tif c2=C1-"+fileNameWithoutExtension+".tif create");
	//Stack.setDisplayMode("grayscale");
	savePath = "/Users/bementmbp/Desktop/BementLab/2_Projects/29_tripleWavePaper/Figures/Figure01/tripleWaves/200200-201200_singleLabels_data/rGBD/0_Raw-mCh_Raw_Utr/";
	saveAs("Tiff",savePath + newFileName);
	close();	
	
}



