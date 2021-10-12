fileName = getInfo("image.title"); 
//gets and saves the file name for later

dotIndex = indexOf(fileName, "."); 
//index of "."

if (dotIndex > 0) {
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_avgCorr.tif" ;
} else {
	newFileName = fileName + "_avgCorr.tif" ;
}

run("Z Project...", "projection=[Average Intensity]");
imageCalculator("Divide create 32-bit stack", fileName,"AVG_" + fileName);
selectWindow("Result of " + fileName);
setMinAndMax(0, 10);
run("16-bit");
run("Enhance Contrast", "saturated=0.15");