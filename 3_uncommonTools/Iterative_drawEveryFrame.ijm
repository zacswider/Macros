
getDimensions(width, height, channels, slices, frames)
for (i=1; i<=frames; i++) { //runs a loop through each frame in the series
	Stack.setFrame(i) ;    //changes the slice for each position in the loop
	run("Draw", "slice");
}
