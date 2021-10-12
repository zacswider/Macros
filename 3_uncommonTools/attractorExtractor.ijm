//THIS PROGRAM GENERATES AN ROI, SAVES THE Z-AXIS PROFILE FROM THAT ROI TO A .CSV FILE,
//MOVES THE ROI OVER BY ONE ROI-LENGTH, AND REPEATS THE PROCESS UNTIL IT HAS COLLECTED THE
//Z-AXIS PROFILE INFORMATION FROM EVERY POINT IN THE FOV



getDimensions(width, height, channels, slices, frames) ;		
//gets and saves the movie dimensions for later use

boxSize = getNumber("how large would you like your box to be?", 20) ; 
//opens dialogue box with the default value of 12 pixels

startingY = 0;
//sets the starting y coordinate for the box to zero (upper left corner)

counter=1;
//sets a counter for the file name to increases by 1 with every trip through the loop

yRemnant = (height - boxSize) ;
//set a counting variable that will move the box down by one box increment

while (yRemnant>0) {
	startingX = 0;
	//set a counting variable that will move the box sidewise by one box increment
	xRemnant = (width - boxSize);
	while (xRemnant>0) {
		makeRectangle(startingX, startingY, boxSize, boxSize);

		run("Plot Z-axis Profile");
		Plot.getValues(x, y);
		close();
		run("Clear Results");
		Array.show(y);
		saveAs("Results", "/Users/bementmbp/Desktop/test3/"+counter+".csv");
		run("Close");

		counter = (counter + 1);
		xRemnant = (xRemnant-boxSize);
		startingX = (startingX + boxSize);
	}

	yRemnant = (yRemnant - boxSize) ;
	startingY = (startingY + boxSize);
}





