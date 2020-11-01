//This macro creates a profile plot from a movie of n different channels and combines/displays the plots together	

getDimensions(width, height, channels, slices, frames) ;		
//gets and saves the movie dimensions for later use

fileName = getInfo("image.title"); 
//gets and saves the file name for later

colorOptions = newArray("Red", "Green", "Blue", "Grey", "Cyan", "Magenta", "Yellow");
//creates an array of LUT options 
channelArray = newArray("There is no Ch0", "Ch1LUT", "Ch2LUT", "Ch3LUT", "Ch4LUT")
//creates an array of variables to hold the user-specified LUT options

counter = 1 //creates a counter variable that starts as 1 and increases by 1 with every trip through the loop
while (counter <= channels) {  //runs a loop as long as the there are still channels left to assign LUTs to
	if (counter == 1) {
		default = "Green" ;
	}  //for channnel 1 the default color is green, but any can be expected
	if (counter == 2) {
		default = "Magenta" ;
	}  //for channnel 2 the default color is magenta, but any can be expected
	if (counter == 3) {
		default = "Cyan" ;
	}  //for channnel 3 the default color is cyan, but any can be expected
	if (counter == 4) {
		default = "Yellow" ;
	}  //for channnel 4 the default color is yellow, but any can be expected
	Dialog.create("Channel " + counter + " LUT options"); //creates a new dialogue box titled "LUT options"
	Dialog.addMessage("Please assign a LUT to channel " + counter); //Asks the user to choose a LUT for channel 1 through n
	Dialog.addChoice("Ch" + counter + ":", colorOptions, default);  //Assigns the LUT array as color options
	channelArray[counter] = Dialog.getChoice(); //Assigns the chosen LUT to the variable in the channel array corresponding to the chosen channel
	Dialog.show();  //shows the dialogue box
	counter += 1; //loops through again
}

secondCounter = 1 ;  //creates a counter variable that starts as 1 and increases by 1 with every trip through the loop
while (secondCounter <= channels) {  //runs a loop as long as the there are still channels left to plot the profile of
	Stack.setPosition(secondCounter, 1, 1); //moves to the active channel
	run("Plot Z-axis Profile");      //plots the signal profile
	rename("C" + secondCounter);     //renames the profile window
	run("8-bit");                    //converst to 8-bit
	run("Invert");                   //inverts the channel
	selectWindow(fileName);          //selects the starting window
	secondCounter += 1; //increases counter value and loops through again
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

Stack.setDisplayMode("composite");

thirdCounter = 1 ;
while (thirdCounter <= channels) {  //runs a loop as long as the there are still channels left to duplicate
	Stack.setChannel(thirdCounter); //selects the active channel
	run(channelArray[thirdCounter]); //assigns the user-specific LUT for that channel
	thirdCounter += 1; //increases counter value and loops through again
}
