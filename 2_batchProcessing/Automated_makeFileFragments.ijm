

while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dir = getInfo("image.directory");
	//directory that the image was loaded from
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	
	fragments = newArray("1-20", "21-40", "41-60");
	for (i=0; i<fragments.length; i++) { // one loop for every item in the specified array
		newFileName = fileNameWithoutExtension + "_" + fragments[i] + ".tif" ;
		run("Duplicate...", "title=" + newFileName + " duplicate frames=" + fragments[i]);
		saveAs("Tiff", dir + newFileName);
		close();
		}
	
	close();
	
}
