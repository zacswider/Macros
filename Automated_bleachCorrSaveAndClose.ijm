
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	path = getDirectory("image") ;
	//saves path that the image is saved to
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "BleachCorr.tif" ;

	run("Split Channels");
	selectWindow("C1-"+fileName);
	//run("Reverse");
	run("Bleach Correction", "correction=[Exponential Fit]");
	selectWindow("y = a*exp(-bx) + c");
	close();
	selectWindow("DUP_C1-"+fileName);
	//run("Reverse");
	rename("channel1");
	selectWindow("C1-"+fileName);
	close();
	selectWindow("C2-"+fileName);
	run("Bleach Correction", "correction=[Exponential Fit]");
	selectWindow("y = a*exp(-bx) + c");
	close();
	selectWindow("DUP_C2-"+fileName);
	rename("channel2");
	selectWindow("C2-"+fileName);
	close();
	run("Merge Channels...", "c1=channel1 c2=channel2 create");
	
	saveAs("Tiff","/Volumes/FlashSSD/211008_Live_SFC_Ocyte_GFP-wGBD_mCh-Utr/0_crop/imm_bleachCorr/"+newFileName);	
	close();
	
	
					}