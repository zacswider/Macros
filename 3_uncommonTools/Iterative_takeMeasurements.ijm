getDimensions(width, height, channels, slices, frames) ; //extracts image dimensions
for (i=1; i<=frames; i++) { //runs a loop
	run("Measure");
	run("Next Slice [>]");
}