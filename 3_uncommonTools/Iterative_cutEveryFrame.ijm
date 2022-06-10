getDimensions(width, height, channels, slices, frames);
for (i = 1; i <= frames; i++) {
	for (j = 1; j <=2; j++) {
		Stack.setFrame(i);
		Stack.setChannel(j);
		run("Cut");
	}
}
s