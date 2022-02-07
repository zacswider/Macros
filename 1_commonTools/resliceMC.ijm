/*
 * This macro reslices and creates a rolling z-projection from an image with up to four channels.
 * The file must be associated with a save path before running.
 */

fileName = getInfo("image.filename") ; 	//saves image name for future use
dotIndex = indexOf(fileName, ".");  	//this and the following line get the file name without the extension
fileNameWithoutExtension = substring(fileName, 0, dotIndex);//this and the above line get the file name without the extension
newFileName = fileNameWithoutExtension + "reslice.tif" ;	//sets a file name for the resliced image
getDimensions(width, height, channels, slices, frames) ;	//gets and saves the movie dimensions for later use

resliceOptions = newArray("Left", "Top");			//options for following dialog box
Dialog.create("reslice options"); 					//creates a new dialogue box titled "reslice options"
Dialog.addMessage("Would you like to reslice from the top or the left?");	//adds a message
Dialog.addChoice("reslice from:", resliceOptions);	//creates a choice of directions
Dialog.show();  //shows the dialogue box
resliceAnswer = Dialog.getChoice();					//saves the answer

projectionOptions = newArray("Average Intensity", "Max Intensity");	//options for the following dialog box
Dialog.create("projection options"); 								//creates a new dialogue box titled "projection options"
Dialog.addMessage("Do you prefer an average or maximum rolling projection?");	//adds a message
Dialog.addChoice("rolling:", projectionOptions);	//creates a choice of projection types
Dialog.show();  //shows the dialogue box
projectionAnswer = Dialog.getChoice();				//saves the answer

rollingAverageLength = getNumber("how many frames would you like to rolling project?", 8) ;	
//Asks the user to input the number of frames they would like to create a rolling z projection with

counter = 1 //creates a counter variable that starts as 1 and increases by 1 with every trip through the loop
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
	colors_threeChannel = newArray("Green", "Magenta");
	for (i=0; i<colors_threeChannel.length; i++) { // one loop for every item in the specified array
		Stack.setChannel(i+1);
		//run("Enhance Contrast", "saturated=" + percentSaturation);
		run(colors_threeChannel[i]); // sets the LUT based on the specified array
		}
} //merges two channels together

if (channels == 3) {
	run("Merge Channels...", "c1=C1 c2=C2 c3=C3 create");
	colors_threeChannel = newArray("Green", "Magenta", "Grays");
	for (i=0; i<colors_threeChannel.length; i++) { // one loop for every item in the specified array
		Stack.setChannel(i+1);
		//run("Enhance Contrast", "saturated=" + percentSaturation);
		run(colors_threeChannel[i]); // sets the LUT based on the specified array
		}
} //merges 3 channels together

if (channels == 4) {
	run("Merge Channels...", "c1=C1 c2=C2 c3=C3 c4=C4 create");
} //merges 4 channels together
//run("Scale...", "x=1.0 y=3 z=1.0 width=409 height=180 depth=409 interpolation=Bicubic average create");
setSlice(20);		//if desired, move to the middle of the stack before auto scaling
Stack.setChannel(1);
resetMinAndMax();
Stack.setChannel(2);
resetMinAndMax();
rename(newFileName);