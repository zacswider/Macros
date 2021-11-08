while (nImages > 0) {
	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_volCorr.tif" ;
	
	correctionFactor = 1.0;
	
	run("Split Channels");
	selectWindow("C2-"+fileName);
	run("Multiply...", "value="+correctionFactor+" stack");
	imageCalculator("Divide create 32-bit stack", "C2-"+fileName,"C1-"+fileName);
	selectWindow("C2-"+fileName);
	close();
	selectWindow("C1-"+fileName);
	close();
	selectWindow("Result of C2-"+fileName);
	setMinAndMax(0, 10);
	run("16-bit");
	//run("Running ZProjector2", "project=2 projection=[Average Intensity]");
	//selectWindow("C3-"+fileName);
	//run("Running ZProjector2", "project=2 projection=[Average Intensity]");
	//selectWindow("Result of C1-"+fileName);
	//close();
	//selectWindow("C3-"+fileName);
	//close();
	//run("Merge Channels...", "c1=[Result of C1-"+fileName+":Group size = 2.] c2=[C3-"+fileName+":Group size = 2.] create");
	
	//run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");
	//Stack.setChannel(1);
	//run("Green");
	//run("Enhance Contrast", "saturated=0.15");
	//Stack.setChannel(2);
	//run("Magenta");
	//run("Enhance Contrast", "saturated=0.15");
	saveAs("Tiff","/Volumes/FlashSSD/211008_Live_SFC_Aegg_BFP_GFP-pGBD_mCh-2rGBD_iRFP-Utr_MgcWT/0_CropBFPpGBD_volCorr/"+newFileName);
	close();
					}