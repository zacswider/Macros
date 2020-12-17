getDimensions(width, height, channels, slices, frames) ;		
//gets and saves the movie dimensions for later use

if (Stack.isHyperstack != 0) {
	exit("active window must be a stack");						
} 
//exits the macro if the file is a hyperstack

if (nSlices == 1) {  
	//nSlices returns the number of slices in an series											
	exit("active window must be a time series");  				
} 
//exits the macro if the active window is not an image

fileName = getInfo("image.filename") ; 
//saves image name for future use
path = getDirectory("image") ;  
//returns the path to the directory that the active image was loaded from
dotIndex = indexOf(fileName, ".");  
//this and the following line get the file name without the extension
fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
//this and the above line get the file name without the extension
folderName = path + fileNameWithoutExtension + "_RollAvg2-2C"; 
//saves the file name without the extension to the variable folderName
File.makeDirectory(folderName); 
//Creates a new folder to store all your shit in, within the directory that the active image is from

run("Running ZProjector2", "project=2 projection=[Average Intensity]");
run("Duplicate...", "title=1Channel duplicate");
run("Duplicate...", "title=2Channel duplicate");
run("Merge Channels...", "c2=1Channel c6=2Channel create ignore");
run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");
saveAs("Tiff", folderName + "/" + fileNameWithoutExtension + "_RollAvg2-2C");
close();
close();
close();