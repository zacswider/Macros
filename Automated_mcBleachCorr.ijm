
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_bleachCorr.tif" ;

	run("Split Channels");
	selectWindow("C1-"+fileNameWithoutExtension+".tif");
	print(fileNameWithoutExtension);
	run("Bleach Correction", "correction=[Simple Ratio] background=0");
	selectWindow("C2-"+fileNameWithoutExtension+".tif");
	print(fileNameWithoutExtension);
	run("Bleach Correction", "correction=[Simple Ratio] background=0");
	print(fileNameWithoutExtension);
	run("Merge Channels...", "c1=DUP_C1-"+fileNameWithoutExtension+".tif c2=DUP_C2-"+fileNameWithoutExtension+".tif create");
	
	
	saveAs("Tiff","/Volumes/FlashSSD/210416_Live_SFC_Ocyte_GFP-wGBD_mCh-rGBD_Utr647_LatB_CK666/0_Analysis/wGBDrGBD_bleachCorr/"+newFileName);
	close();	

	selectWindow("C1-"+fileNameWithoutExtension+".tif");
	close();
	selectWindow("C2-"+fileNameWithoutExtension+".tif");
	close();
					}



