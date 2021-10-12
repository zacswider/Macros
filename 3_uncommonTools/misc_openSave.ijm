fileName = getInfo("image.filename") ; 
//saves image name for future use
dotIndex = indexOf(fileName, ".");  
//this and the following line get the file name without the extension
fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
//this and the above line get the file name without the extension
newFileName = fileNameWithoutExtension + "-Crop" ;
finalFileName = newFileName + "Processed.tif" ;
rename("findThisWindowLater");

getDimensions(width, height, channels, slices, frames) ;		
//gets and saves the movie dimensions for later use

run("Restore Selection");
run("Duplicate...", finalFileName + " duplicate");

differenceNumber = 6 ; 
//asks the user for the number of frames to subtract

counter = 1 //creates a counter variable that starts as 1 and increases by 1 with every trip through the loop
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
	selectWindow("findThisWindowLater");
	counter += 1; //loops through again
}

run("Merge Channels...", "c1=C1 c2=C2 create");
selectWindow("Merged");

run("Split Channels"); //splits channels if there is more than 1 channel
for(i=1; i<=channels; i++){ //loops through n number of channels
	selectWindow("C"+ i + "-Merged");  //selects the first channel
		run("Running ZProjector2", "project=2 projection=[Average Intensity]");
		rename("Channel"+i);
}

run("Merge Channels...", "c1=Channel1 c2=Channel2 create");
run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");
rename(finalFileName);

saveAs("Tiff", "/Volumes/Processed/remoteAnalysis/Analysis18-MgcRacGAP-DiffShort/" + finalFileName);
close();
close();
close();
close();
close();