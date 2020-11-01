
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_Reg.tif" ;

	//makeRectangle(240, 1, 163, 511);
	//run("Crop");	
	
	run("Re-order Hyperstack ...", "channels=[Slices (z)] slices=[Channels (c)] frames=[Frames (t)]");
	run("PoorMan3DReg ", "transformation=Translation number=2 projection=[Max Intensity]");
	run("Re-order Hyperstack ...", "channels=[Slices (z)] slices=[Channels (c)] frames=[Frames (t)]");
	
	Stack.setDisplayMode("composite");
	Stack.setChannel(1);
	run("Green");
	resetMinAndMax();
	Stack.setChannel(2);
	run("Magenta");
	resetMinAndMax();
	//Stack.setChannel(3);
	//run("Grays");
	//resetMinAndMax();
	
	saveAs("Tiff","/Volumes/FlashSSD/201030_Live_SFC_Aegg_GFP-wGBD_Utr647_Gap1-MgcMO/Reg/"+newFileName);
	close();
	
					}