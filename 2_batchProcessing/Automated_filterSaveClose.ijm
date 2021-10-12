
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_DNoise.tif" ;

	run("Remove Outliers...", "radius=1 threshold=1000 which=Bright stack");
	resetMinAndMax();

	saveAs("Tiff","/Volumes/FlashSSD/201104_Live_Flvw_Aegg_GFP-wGBD_Cdc42T17N/MaxFilter/"+newFileName);
	close();
	
					}