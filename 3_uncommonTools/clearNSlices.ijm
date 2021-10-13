getDimensions(width, height, channels, slices, frames) ;
Stack.getPosition(channel, slice, frame);

for (i=frame; i<=frames; i++) { //runs a loop
	Stack.setFrame(i);
	Stack.setSlice(slice)
	run("Cut");
}