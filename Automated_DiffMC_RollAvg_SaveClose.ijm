//This macro creates difference movies from multi-channel movies

while (nImages > 0) {

	getDimensions(width, height, channels, slices, frames) ;		
	//gets and saves the movie dimensions for later use
	path = getDirectory("image") ; 
	fileTitle = getInfo("image.title"); 
	//gets and saves the file name for later
	
	differenceNumber = 2 ; 
	//asks the user for the number of frames to subtract
	
	averageNumber = 2 ;
	//asks the user for the number of frames to average
	
	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_Diff" + differenceNumber + "Roll" + averageNumber + ".tif" ;
	
	run("Remove Outliers...", "radius=1 threshold=600 which=Bright stack");
	
	counter = 1 ;//creates a counter variable that starts as 1 and increases by 1 with every trip through the loop
	while (counter <= channels) {  //runs a loop as long as the there are still channels left to duplicate
		Stack.setChannel(counter); //moves to channel x (whatever the x number through the loop is)
		run("Duplicate...", "title=Channel_" + counter + " duplicate channels=" + counter);
		//duplicates the active channel and renames it "Channel_X"
		setSlice(1);
		run("Duplicate...", "title=firstDup duplicate");
		run("Duplicate...", "title=lastDup duplicate");
		selectWindow("firstDup") ;
		for (i=1; i<=differenceNumber; i++) { //runs a loop
			run("Delete Slice");    //changes the slice for each position in the loop
		}
		selectWindow("lastDup") ;
		run("Reverse");
		for (i=1; i<=differenceNumber; i++) { //runs a loop
			run("Delete Slice");    //changes the slice for each position in the loop
		}
		run("Reverse");
		imageCalculator("Subtract create 32-bit stack", "firstDup","lastDup");
		selectWindow("firstDup") ;
		close() ; //closes first intermediate
		selectWindow("lastDup") ;
		close() ; //closes last intermediate
		selectWindow("Channel_" + counter);
		close(); //closes the duplicated channel selection
		selectWindow("Result of firstDup") ;
		rename("C" + counter) ; //renames difference movie to the channel it was generated from
		getMinAndMax(min, max) ;
		setMinAndMax(0, 65536) ; //thresholds the video 
		run("16-bit");
		run("Enhance Contrast", "saturated=0.35");
		selectWindow(fileTitle);
		counter += 1; //loops through again
	
	selectWindow("C1");}
	run("Running ZProjector2", "project=" + averageNumber + " projection=[Average Intensity]");
	//fullPath = path + "/" + newFileName;
	//save(fullPath) ;
	saveAs("Tiff","/Volumes/FlashSSD/210212_Live_SFC_Aegg_GFP-wGBD_mCh-Utr_GAP1i_GAP17i/0_analysis/regUtrCrop_Diff2Roll2/"+newFileName);
	close() ;							
	rename("deleteThis");
	close() ;
	close() ;
	
					}
