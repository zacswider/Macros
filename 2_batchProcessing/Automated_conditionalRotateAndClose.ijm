while (nImages > 0) {

	getDimensions(width, height, channels, slices, frames) ;

	if (width > height) {
		close();
		} 
	
	if (height > width) {
			run("Rotate 90 Degrees Right");
			run("Save");
			close();
		} 
	
}