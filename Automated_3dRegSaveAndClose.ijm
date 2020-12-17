
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	path = getDirectory("image") ;
	//saves path that the image is saved to
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_CropReg.tif" ;

	fullPath = path + "/" + newFileName;
	//creates a save path for the newly created file
	
	makeRectangle(229, 0, 246, 512);
	run("Crop");	

	run("Re-order Hyperstack ...", "channels=[Slices (z)] slices=[Channels (c)] frames=[Frames (t)]");
	run("PoorMan3DReg ", "transformation=Translation number=3 projection=[Max Intensity]");
	run("Re-order Hyperstack ...", "channels=[Slices (z)] slices=[Channels (c)] frames=[Frames (t)]");


	Stack.setDisplayMode("composite");
	Stack.setChannel(1);
	run("Green");
	resetMinAndMax();
	Stack.setChannel(2);
	run("Magenta");
	resetMinAndMax();
	Stack.setChannel(3);
	run("Grays");
	resetMinAndMax();
	
	saveAs("Tiff","/Volumes/FlashSSD/201215_Live_SFC_Aegg_GFP-rGBD_mCh_iRFP-Utr/0_Analysis_reg/"+newFileName);	
	//save(fullPath) ;
	close();
	
					}