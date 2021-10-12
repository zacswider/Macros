getDimensions(width, height, channels, slices, frames) ;		
//gets and saves the movie dimensions for later use

subMovieLength = getNumber("how many frames do you want in your sub-movie?", 100) ; 
//querries user for the number of frames desired per sub-movie		
if ((frames + slices - 1) < subMovieLength) { 
	//should allow for time series to be stored as either slices or frames	
	exit("sub-movie length can't be longer than the whole movie");
	//exits the macro if the movie is too short to duplicate the desired number of frames
} 

fileName = getInfo("image.filename") ; 
//saves image name for future use
path = getDirectory("image") ;  
//returns the path to the directory that the active image was loaded from
dotIndex = indexOf(fileName, ".");  
//this and the following line get the file name without the extension
fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
//this and the above line get the file name without the extension
folderName = path + fileNameWithoutExtension; 
//saves the file name without the extension to the variable folderName
File.makeDirectory(folderName); 
//Creates a new folder to store all your shit in, within the directory that the active image is from
subMovieShift = getNumber("¿Cuántos cuadros quieres entre sub-películas?", 25) ; 
//querries user for the number of frames to shift between each sub-movie
//"¿Cuántos cuadros quieres entre sub-películas?" means "How many frames do you want between sub-movies?"
beginningFrame = 1 ;
//sets the beginning frame to start duplicating from to 1
endingFrame = subMovieLength ;
//sets the ending frame to stop duplicating frame to the length of the desired sub-movie
while (endingFrame <= (frames + slices - 1)) {
	//Initiates a while loop that should run as long as there is enough frames in the original movie to 
	//continue duplicating sub-movies of the same length
	print(beginningFrame);
	print(endingFrame);
	run("Duplicate...", "duplicate channels=1-2 frames=beginningFrame-endingFrame");
	//makes a sub-movie from the original movie using 'beginningFrame' and 'endingFrame' as start-end
	beginningFrameText = "" + beginningFrame;
	//turns the beginning frame into a string variable that can be changed
	endingFrameText = "" + endingFrame;
	//turns the ending frame into a string variable that can be changed
	if (lengthOf(beginningFrameText) < 2) {
		beginningFrameText = "000" + beginningFrameText ;
	}
	if (lengthOf(beginningFrameText) < 3) {
		beginningFrameText = "00" + beginningFrameText ;
	}
	if (lengthOf(beginningFrameText) < 4) {
		beginningFrameText = "0" + beginningFrameText ;
	}
	if (lengthOf(endingFrameText) < 2) {
		endingFrameText = "000" + endingFrameText ;
	}
	if (lengthOf(endingFrameText) < 3) {
		endingFrameText = "00" + endingFrameText ;
	}
	if (lengthOf(endingFrameText) < 4) {
		endingFrameText = "0" + endingFrameText ;
	}//The "if" statements above ensure that the beginning and ending frames have 4 values so that later python and excel will organize them appropriately

	tempName = fileNameWithoutExtension + "_" + beginningFrameText + "-" + endingFrameText ;
	//the variable appends _beginningFrame-endingFrame to the end of the file name
	//this variable will change with every loop
	rename(tempName) ;
	//renames the newly duplicated sub-movie to include _beginningFrame-endingFrame at the end of the file name
	tempFolderName = folderName + "/" + tempName;
	//the variable makes a file path to a new folder within the original directory that matches the file name
	//this variable will change with every loop
	File.makeDirectory(tempFolderName) ;
	//makes a new directory for each loop to save each sub-folder to
	fullPath = tempFolderName + "/" + tempName + ".tif" ;
	//this variable includes the full path specified above, and also specifies the file name '{tempName}.tif'
	//this variable will change with every loop
	save(fullPath) ;
	//saves the active image (newly duplicated sub-movie) to the path specified above
	close();
	//closes the active image. The original image sequence will become the new active image
	beginningFrame = beginningFrame + subMovieShift ;
	//increases the variable 'beginningFrame' by the desired number of frames between sub-movies 
	//this will change which frames are duplicated in the subsequent loop
	endingFrame = endingFrame + subMovieShift ;
	//increases the variable 'endingFrame' by the desired number of frames between sub-movies 
	//this will change which frames are duplicated in the subsequent loop
}