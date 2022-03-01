
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	dir = "/Volumes/FlashSSD/210416_Live_SFC_Ocyte_GFP-wGBD_mCh-rGBD_Utr647_LatB_CK666/0_Analysis/wGBDrGBD_bleachCorr/";
	dir = getInfo("image.directory");
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_bleachCorr.tif" ;
	getDimensions(width, height, channels, slices, frames);
	run("Split Channels");

	for (i = 1; i <= channels; i++) {
		selectWindow("C" + i + "-"+fileNameWithoutExtension+".tif");
		run("Bleach Correction", "correction=[Simple Ratio] background=0");
		rename("C" + i);
	}

	if (channels == 2) {
		run("Merge Channels...", "c1=C1 c2=C2 create");
	} //merges two channels together
	
	if (channels == 3) {
		run("Merge Channels...", "c1=C1 c2=C2 c3=C3 create");
	} //merges 3 channels together
	
	if (channels == 4) {
		run("Merge Channels...", "c1=C1 c2=C2 c3=C3 c4=C4 create");
	} //merges 4 channels together
	
	if (channels == 1) {
		selectWindow("C1");
	} 

	saveAs("Tiff", dir+newFileName);
	close();	
	
	for (i = 1; i <= channels; i++) {
		close("C" + i + "-"+fileNameWithoutExtension+".tif");
	}
}



