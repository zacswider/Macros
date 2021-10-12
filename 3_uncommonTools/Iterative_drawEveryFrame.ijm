
getDimensions(width, height, channels, slices, frames)
for (i=1; i<=slices; i++) { //runs a loop through each frame in the series
	Stack.setSlice(i) ;    //changes the slice for each position in the loop
	run("Draw", "slice");
}
