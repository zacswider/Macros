//The purpose of this macro is to take a kymograph of an ingressing wound and turn it into a movie 
//that is a single strip of pixels tall, each frame representing a single frame from a 2D movie. This movie
//can then be turned into a profile plot for each channel.

fileName = getTitle() ; 
//saves image name for future use

selectionHeight = getNumber("how many pixels tall should the selection be?", 2) ; 
//Set this to 2 if you would like your selection to be 2 pixels tall	
selectionShift = getNumber("by how many pixels should the selection move between duplications?", 1) ; 
//Set this to 1 if you would like the selection to move down by 1 pixel for every duplication	

getDimensions(width, height, channels, slices, frames) ;		
//gets and saves the movie dimensions for later use

if (channels == 1) {
	makeRectangle(0, 0, width, selectionHeight);
	//generates a selection at the top of the image with the desired width/height
	
	counter = 0; //counter variable stops the loop when all of the selections have been duplicated
	dupNum = 1;  //appended to the duplicated file name so that FIJI can sort them numerically
	while (counter <= (height - selectionHeight)) { //loops until all of the selections have been duplicated
		run("Duplicate...", "title=duplication" + dupNum + " duplicate"); //duplicates selection
		counter = counter + selectionShift ; //increases the counter value according to the desired shift in the selection
		dupNum = dupNum + 1 ;				//increases the duplication number by 1
		selectWindow(fileName);				//re-selects the original file
		Roi.move(0, counter) ;				//moves the selection down by the desired amount
	}
	run("Images to Stack", "method=[Copy (center)] name=Stack title=duplication use");
	//concatenates all duplicated images into a stack
}

if (channels > 1) {
	run("Split Channels"); //splits channels if there is more than 1 channel
	for(i=1; i<=channels; i++){ //loops through n number of channels
		selectWindow("C"+ i + "-"+fileName);  //selects the first channel
			makeRectangle(0, 0, width, selectionHeight);
			counter = 0;
			dupNum = 1;
			while (counter <= (height - selectionHeight)) {
				run("Duplicate...", "title=duplication" + dupNum + " duplicate");
				counter = counter + selectionShift ;
				dupNum = dupNum + 1 ;
				selectWindow("C"+ i + "-"+fileName);
				Roi.move(0, counter) ;
			}
			run("Images to Stack", "method=[Copy (center)] name=C"+i+"Stack title=duplication use");
			//iterates through the same loop used for single channels above
	}
}

if (channels == 2) {
	run("Merge Channels...", "c1=C1Stack c2=C2Stack create");
	run("Merge Channels...", "c1=C1-"+fileName+" c2=C2-"+fileName+" create");
}

if (channels == 3) {
	run("Merge Channels...", "c1=C1Stack c2=C2Stack c3=C3Stack create");
	run("Merge Channels...", "c1=C1-"+fileName+" c2=C2-"+fileName+" c3=C3-"+fileName+" create");
}

selectWindow("Composite");
run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");