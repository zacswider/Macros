
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_mChBFP.tif" ;
	
	run("Split Channels");
	run("Merge Channels...", "c1=C2-"+fileNameWithoutExtension+".tif c2=C1-"+fileNameWithoutExtension+".tif create");
	
	saveAs("Tiff","/Volumes/FlashSSD/210507_Live_SFC_Aegg_BFP_GFP-wGBD_mCh-2XrGBD_iRFP-Utr_MgcWT/0_analysis/mChBFP-processing/"+newFileName);
	close();	
					}



