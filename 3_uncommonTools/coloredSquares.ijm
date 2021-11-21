setColor("#94e5ff") ;
//setColor("#000000");
height = getHeight() ;     //gets the height of the image for the scaling and looping steps
width = getWidth() ;       //gets the width of the image for the scaling and looping steps
for (i=92; i<=213; i++) { //runs a loop through each frame in the series
	Stack.setSlice(i) ;    //changes the slice for each position in the loop
	fillRect(0, 0, width, height) ;  //draws a rectangle hiding the rest of the kymograph to create the "rolling" effect
}
//i=388; i<=481