//creates a "rolling" kymograph much more quickly than previous version, also allows more user flexibility in choosing
//the input kymograph.  Essentially, this macro just takes an image, makes a stack out of it, and blacks out the bottom
//part of the kymograph on each line

if (nSlices != 1) {  //nSlices returns the number of slices in an series
	exit("start with a kymograph, dummy");  //exits the macro if the active window is not an image
} 
rename("victim") ; //renames the file so the macro can find it later and so the concatenation is easy (removes .tiff suffixes if present)
run("Duplicate...", "victim-1") ; //duplicates the image
run("Concatenate...", "  title=[workInProgress] image1=victim image2=victim-1 image3=[-- None --]");  //concatenates the two images
height = getHeight() ;     //gets the height of the image for the scaling and looping steps
width = getWidth() ;       //gets the width of the image for the scaling and looping steps
run("Scale...", "x=1.0 y=1.0 z=- width=&width height=&height depth=&height interpolation=None average process create");
//scales the kymograph so that there is one "slice" for every line of pixels (i.e. z and height are equivalent)
setColor(0) ;//sets the drawing color to black - you can change this if you want something else
for (i=1; i<height; i++) { //runs a loop through each frame in the series
	Stack.setSlice(i) ;    //changes the slice for each position in the loop
	fillRect(0, i, width, height) ;  //draws a rectangle hiding the rest of the kymograph to create the "rolling" effect
}
selectWindow("workInProgress") ;
close() ; //closes intermediate window

