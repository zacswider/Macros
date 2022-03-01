
while (nImages > 0) {
	dir = getInfo("image.directory");
	fileName = getInfo("image.filename") ; 
	run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");
	saveAs("Tiff", dir + fileName);
	close();
}