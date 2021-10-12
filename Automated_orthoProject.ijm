//This macro creates difference movies from multi-channel movies

while (nImages > 0) {

	getDimensions(width, height, channels, slices, frames) ;		
	//gets and saves the movie dimensions for later use
	path = getDirectory("image") ; 
	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_orthoRollMax10-corrected.tif" ;

	run("Scale...", "x=1.66 y=1.66 z=1.0 width=850 height=850 depth=100 interpolation=Bicubic average process create");
	rename("deleteThis1");
	makeRectangle(188, 142, 512, 512);
	run("Crop");
	run("Reslice [/]...", "output=0.100 start=Left");
	rename("deleteThis2");
	run("Running ZProjector2", "project=10 projection=[Max Intensity]");
	setSlice(50);
	run("Enhance Contrast", "saturated=0.15");
	saveAs("Tiff","/Volumes/FlashSSD/210921_Live_SFC_Ocyte_EB3-GFP_2mCh-EMTB/"+newFileName);
	close();
	selectWindow("deleteThis1");
	close();
	selectWindow("deleteThis2");
	close();
	selectWindow(fileName);
	close();
					}
