
fileName = getInfo("image.filename") ; 
//saves image name for future use
path = getDirectory("image") ;
//saves path that the image is saved to
dotIndex = indexOf(fileName, ".");  
//this and the following line get the file name without the extension
fileNameWithoutExtension = substring(fileName, 0, dotIndex); 

getDimensions(width, height, channels, slices, frames)
// get the dimensions of the active image

run("Clear Results");
// clear the results table so we can add new data

// add each frame to the results table so it's easy to modify with a function
for (i = 1; i <= frames; i++) {
	setResult("Frame", nResults, i);
}

// measure the stimulated regions
makeRectangle(288, 247, 155, 35);
makeMeasurements("Stim1");
makeRectangle(98, 247, 155, 35);
makeMeasurements("Stim2");

run("Rotate 90 Degrees Right");  
// rotate the image so we can measure the control regions

// measure the control regions
makeRectangle(264, 244, 155, 35);
makeMeasurements("Cont1");
makeRectangle(77, 244, 155, 35);
makeMeasurements("Cont2");

function makeMeasurements(title) {
// defines a function that accepts the name of the region being measured (the title)
	Stack.setFrame(1);
	profile = getProfile();
	Array.getStatistics(profile, min, max, mean, stdDev)
	setResult(title, 0, mean);
	for (i = 2; i <= frames; i++) {
		Stack.setFrame(i);
		profile = getProfile();
		Array.getStatistics(profile, min, max, mean, stdDev);
		setResult(title, i-1, max);
	}

}

updateResults;
//path = "/Users/lilahobby/Documents/Bement Lab/Macros/";
saveAs("Results", path + fileNameWithoutExtension + "data.csv");