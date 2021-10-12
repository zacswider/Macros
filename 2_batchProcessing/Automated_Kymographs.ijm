
while (nImages > 0) {

	//This macro reslices and creates a rolling Z projects a selection on an image that has two or more channels.
	
	getDimensions(width, height, channels, slices, frames) ;		
	//gets and saves the movie dimensions for later use
	
	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_KymScaleY4.tif" ;

	resliceAnswer = "Left";
	
	projectionAnswer = "Average Intensity";
	
	rollingAverageLength = 8 ;	
	
	counter = 1 ;//creates a counter variable that starts as 1 and increases by 1 with every trip through the loop
	while (counter <= channels) {  //runs a loop as long as the there are still channels left to duplicate
		Stack.setChannel(counter); //moves to channel x (whatever the x number through the loop is)
		run("Duplicate...", "title=Channel_" + counter + " duplicate channels=" + counter);
		//duplicates the active channel and renames it "Channel_X"
		run("Reslice [/]...", "output=0.500 start=" + resliceAnswer + " avoid");
		//reslices the duplicated selection either from the right or the left depending on the user answer
		run("Running ZProjector2", "project=" + rollingAverageLength+ " projection=[" + projectionAnswer + "]");
		//creates a running z-projection based on the user answers above
		rename("C" + counter);
		//renames the projected kymograph
		selectWindow("Channel_" + counter);
		close(); //closes the duplicated channel selection
		selectWindow("Reslice of Channel_" + counter);
		close(); //closes the non-projected kymograph
		selectWindow(fileName);
		counter += 1; //loops through again
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
	run("Scale...", "x=1.0 y=3 z=1.0 width=409 height=180 depth=409 interpolation=Bicubic average create");

	saveAs("Tiff","/Volumes/FlashSSD/201022_Live_SFC_Aegg_BFP_GFP-xGBD_2mCh-wGBD_Utr647/"+newFileName);
	close();
	close();
	close();	
					}