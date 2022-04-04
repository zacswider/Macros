for (i = 1; i < 100; i++) {
	fileName = getInfo("image.filename") ; 
	dir = getInfo("image.directory");
	print(dir);
	getDimensions(_, _, channels, slices, frames);
	setTool("line");
	waitForUser("Select the long axis of the furrow");
	getLine(x_start_furrow, y_start_furrow, x_end_furrow, y_end_furrow, lineWidth_furrow);
	makeRotatedRectangle(x_start_furrow, y_start_furrow, x_end_furrow, y_end_furrow, lineWidth_furrow);
	
	absolute_position = getSliceNumber();
	current_frame = (absolute_position+1) / (channels*slices);
	
	sample_id = getNumber("enter 0 for control, 1 for experiment", 0) ; 
	run("Duplicate...", "title=temporary_image");
	Stack.setChannel(2);
	run("Delete Slice", "delete=channel");
	run("Grays");
	
	selectWindow(fileName);
	run("Draw", "slice");
	setTool("line");
	waitForUser("select the perpendicular axis of the cell");
	getLine(x_start_perp, y_start_perp, x_end_perp, y_end_perp, lineWidth_perp);
	length = round(get_length());
	waitForUser("select the short axis of the cell");
	width = round(get_length());
	setTool("rectangle");
	waitForUser("select a background region");
	Stack.setChannel(1);
	run("Measure");
	mean_background = round(getResult("Mean", 0));
	run("Clear Results");
	
	selectWindow("temporary_image");
	saveAs("Tiff", dir + "0_furrow_images/" + 
						 sample_id +"_"+ 		// control or expmnt
						 current_frame +"_"+ 	// frame analyzed
						 x_start_furrow +"_"+ 	// x coord for start of line encapsulating furrow
						 y_start_furrow +"_"+ 	// y coord for start of line encapsulating furrow
						 x_end_furrow +"_"+ 	// x end
						 y_end_furrow +"_"+ 	// y end
						 lineWidth_furrow +"_"+ // width
						 x_start_perp +"_"+ 	// x coord for start of line perpendicular to furrow
						 y_start_perp +"_"+ 	// y coord for start of line perpendicular to furrow
						 x_end_perp +"_"+ 		// x end
						 y_end_perp +"_"+ 		// y end
						 mean_background + ".tif");	// mean fluorescence from background ROI
	print("done saving " + sample_id +"_"+ 
						 current_frame +"_"+ 
						 x_start_furrow +"_"+ 
						 y_start_furrow +"_"+ 
						 x_end_furrow +"_"+ 
						 y_end_furrow +"_"+ 
						 lineWidth_furrow +"_"+ 
						 x_start_perp +"_"+ 
						 y_start_perp +"_"+ 
						 x_end_perp +"_"+ 
						 y_end_perp +"_"+ 
						 mean_background + ".tif");
	print("finished annotating " + i + " cells");
	close();
}


function get_length(){
	if (selectionType!=5)
	  exit("Straight line selection required");
	getLine(x1, y1, x2, y2, lineWidth);
	getPixelSize(unit, width, height, depth);
	x1*=width; y1*=height; x2*=width; y2*=height; 
	length = sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
	return length
}