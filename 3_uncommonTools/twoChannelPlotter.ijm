

getDimensions(width, height, channels, slices, frames) ;		
//gets and saves the movie dimensions for later use

fileName = getInfo("image.title"); 
//gets and saves the file name for later

colorOptions = newArray("Red", "Green", "Blue", "Grey", "Cyan", "Magenta", "Yellow");
//
channelArray = newArray("There is no Ch0", "Ch1LUT", "Ch2LUT", "Ch3LUT", "Ch4LUT")
//

counter = 1 //creates a counter variable that starts as 1 and increases by 1 with every trip through the loop
while (counter <= channels) {  //runs a loop as long as the there are still channels left to duplicate
	if (counter == 1) {
		default = "Green" ;
	}
	if (counter == 2) {
		default = "Magenta" ;
	}
	if (counter == 3) {
		default = "Cyan" ;
	}
	if (counter == 4) {
		default = "Yellow" ;
	}
	Dialog.create("Channel " + counter + " LUT options"); //creates a new dialogue box titled "LUT options"
	Dialog.addMessage("Please assign a LUT to channel " + counter);
	Dialog.addChoice("Ch" + counter + ":", colorOptions, default);
	//
	channelArray[counter] = Dialog.getChoice(); 
	//
	Dialog.show();  //shows the dialogue box
	counter += 1; //loops through again
}

secondCounter = 1 ;
while (secondCounter <= channels) {  //runs a loop as long as the there are still channels left to duplicate
	Stack.setChannel(secondCounter);
	run("Plot Z-axis Profile");
	rename("C" + secondCounter);
	run("8-bit");
	run("Invert");
	selectWindow(fileName);
	secondCounter += 1; //loops through again
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
	Stack.setChannel(thirdCounter);
	run(channelArray[thirdCounter]);
	thirdCounter += 1; //loops through again
}
