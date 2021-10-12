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

frameShift = getNumber("how many frames do you shifter per color?", 3) ; 
//querries user for the desired number of frames shifted per color

run("Duplicate...", "title=obscureFileName duplicate");

//saves image name for future use

beginning = 1 ;
end = (frames + slices - 1) - 2*frameShift ;

run("Duplicate...", "title=cyan duplicate range=beginning-end");

beginning = beginning + frameShift ;
end = end + frameShift ; 

selectWindow("obscureFileName");
run("Duplicate...", "title=yellow duplicate range=beginning-end");

beginning = beginning + frameShift ;
end = end + frameShift ; 

selectWindow("obscureFileName");
run("Duplicate...", "title=magenta duplicate range=beginning-end");

imageCalculator("Max create stack", "cyan","yellow");
selectWindow("Result of cyan");
rename("green");
imageCalculator("Max create stack", "yellow","magenta");
selectWindow("Result of yellow");
rename("red");
imageCalculator("Max create stack", "magenta","cyan");
selectWindow("Result of magenta");
rename("blue");
run("Merge Channels...", "c1=red c2=green c3=blue create ignore");

selectWindow("obscureFileName");
close();
selectWindow("yellow");
close();
selectWindow("cyan");
close();
selectWindow("magenta");
close();

run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");