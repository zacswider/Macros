//
// Flamingo Converter
//

//version
version = "1.1";

//start log
IJ.log(" ");
selectWindow("Log");
run("Close");
IJ.log("---");
IJ.log("Flamingo Converter");

//set options
setOption("ExpandableArrays", true);

//get date and time
MonthNames = newArray("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
DayNames = newArray("Sun", "Mon","Tue","Wed","Thu","Fri","Sat");
getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
TimeString = DayNames[dayOfWeek]+"-";
if (dayOfMonth<10) {TimeString = TimeString+"0";}
TimeString = TimeString+dayOfMonth+"-"+MonthNames[month]+"-"+year+"_";
if (hour<10) {TimeString = TimeString+"0";}
TimeString = TimeString+hour;
if (minute<10) {TimeString = TimeString+"0";}
TimeString = TimeString+minute;
if (second<10) {TimeString = TimeString+"0";}
TimeString = TimeString+second;
IJ.log(TimeString);

//get list of luts
//internal
luts_internal = newArray("Fire", "Grays", "Ice", "Spectrum", "3-3-2 RGB", "Red", "Green", "Blue", "Cyan", "Magenta", "Yellow", "Red/Green");
//luts folder
lutdirname="luts";
lutdir=getDirectory("startup")+lutdirname+File.separator;
list_luts = getFileList(lutdir);
for (i=0; i<list_luts.length; i++) {
	if (endsWith(list_luts[i], ".lut")) {
		list_luts[i] = substring(list_luts[i],0,lengthOf(list_luts[i])-4);
	}
}
//combine arrays
list_luts = Array.concat(luts_internal,list_luts);
default_luts = newArray("Yellow", "Magenta", "Green", "Blue", "Grays");
default_channels = newArray("640nm", "561nm", "488nm", "405nm", "LED");

//get path and generate list of stacks
IJ.log("-");
IJ.log("Waiting for user input...");
path = getDirectory("Select a folder");
list_files = getFileList(path);
list_stacks = newArray;
count_stacks = 0;
for (a = 0; a < list_files.length; a++) {
	filename = list_files[a];
	if (lengthOf(filename) == 54) {
		if (endsWith(filename, ".tif")) {
			fileformat = "tif";
			list_stacks[count_stacks] = filename;
			//increase stack count by 1
			count_stacks++;
		}
		if (endsWith(filename, ".raw")) {
			fileformat = "raw";
			list_stacks[count_stacks] = filename;
			//increase stack count by 1
			count_stacks++;
		}
	}
}

//collect experiment properties
tif_sample = newArray(lengthOf(list_stacks));
tif_timepoint = newArray(lengthOf(list_stacks));
tif_view = newArray(lengthOf(list_stacks));
tif_region = newArray(lengthOf(list_stacks));
tif_tileX = newArray(lengthOf(list_stacks));
tif_tileY = newArray(lengthOf(list_stacks));
tif_channel = newArray(lengthOf(list_stacks));
tif_illumination = newArray(lengthOf(list_stacks));
tif_camera = newArray(lengthOf(list_stacks));
channels_used = newArray(false, false, false, false, false);
C00 = false;
C01 = false;
C02 = false;
C03 = false;
C04 = false;
I0 = false;
I1 = false;
D0 = false;
D1 = false;
tif_planes = newArray(lengthOf(list_stacks));

//loop over list of stacks - to be simplified by considering filename length of 54
IJ.log("-");
IJ.log("List of stacks:");
for (a = 0; a<lengthOf(list_stacks); a++) {
	tif_sample[a] = parseInt(substring(list_stacks[a],1,lengthOf(list_stacks[a])-50));
	tif_timepoint[a] = parseInt(substring(list_stacks[a],6,lengthOf(list_stacks[a])-42));
	tif_view[a] = parseInt(substring(list_stacks[a],14,lengthOf(list_stacks[a])-37));
	tif_region[a] = parseInt(substring(list_stacks[a],19,lengthOf(list_stacks[a])-31));
	tif_tileX[a] = parseInt(substring(list_stacks[a],25,lengthOf(list_stacks[a])-26));
	tif_tileY[a] = parseInt(substring(list_stacks[a],30,lengthOf(list_stacks[a])-21));
	tif_channel[a] = parseInt(substring(list_stacks[a],35,lengthOf(list_stacks[a])-17));
	if (tif_channel[a] == 0) {
		channels_used[0] = true;
	}
	if (tif_channel[a] == 1) {
		channels_used[1] = true;
	}
	if (tif_channel[a] == 2) {
		channels_used[2] = true;
	}
	if (tif_channel[a] == 3) {
		channels_used[3] = true;
	}
	if (tif_channel[a] == 4) {
		channels_used[4] = true;
	}
	tif_illumination[a] = parseInt(substring(list_stacks[a],39,lengthOf(list_stacks[a])-14));
	if (tif_illumination[a] == 0) {
		I0 = true;
	}
	if (tif_illumination[a] == 1) {
		I1 = true;
	}
	tif_camera[a] = parseInt(substring(list_stacks[a],42,lengthOf(list_stacks[a])-11));
	if (tif_camera[a] == 0) {
		D0 = true;
	}
	if (tif_camera[a] == 1) {
		D1 = true;
	}
	tif_planes[a] = parseInt(substring(list_stacks[a],45,lengthOf(list_stacks[a])-4));
	//list file name and properties
	IJ.log(a + ": " + list_stacks[a]);
	IJ.log("sample " + parseInt(tif_sample[a])+1 + ", timepoint " + parseInt(tif_timepoint[a])+1 + ", view " + parseInt(tif_view[a])+1 + ", region " + parseInt(tif_region[a])+1 + ", tile " + parseInt(tif_tileX[a])+1 + "x" + parseInt(tif_tileY[a])+1 + ", channel " + parseInt(tif_channel[a])+1 + ", illumination " + parseInt(tif_illumination[a])+1 + ", detection " + parseInt(tif_camera[a])+1 + ", " + parseInt(tif_planes[a]) + " planes");
}

//count number of samples, timepoints, channels, illumination sides and cameras
Array.getStatistics(tif_sample, min, max, mean, stdDev);
nr_samples = max+1;
Array.getStatistics(tif_timepoint, min, max, mean, stdDev);
nr_timepoints = max+1;
Array.getStatistics(tif_view, min, max, mean, stdDev);
nr_views = max+1;
Array.getStatistics(tif_region, min, max, mean, stdDev);
nr_regions = max+1;
Array.getStatistics(tif_tileX, min, max, mean, stdDev);
nr_tileX = max+1;
Array.getStatistics(tif_tileY, min, max, mean, stdDev);
nr_tileY = max+1;
nr_channels = 0;
nr_illuminations = 0;
nr_cameras = 0;
for (i=0; i<5; i++) {
	nr_channels = nr_channels + channels_used[i];
}
if (I0 == true) {
	nr_illuminations++;
}
if (I1 == true) {
	nr_illuminations++;
}
if (D0 == true) {
	nr_cameras++;
}
if (D1 == true) {
	nr_cameras++;
}

//data summary
IJ.log("-");
IJ.log("Data summary:");
IJ.log(list_stacks.length + " " + fileformat + " stacks");
IJ.log(nr_samples + " samples");
IJ.log(nr_timepoints + " timepoints");
IJ.log(nr_views + " views");
IJ.log(nr_regions + " regions");
IJ.log(nr_tileX + "x" + nr_tileY + " tiles");
IJ.log(nr_channels + " channels");
IJ.log(nr_illuminations + " illumination sides");
IJ.log(nr_cameras + " detection sides");

//collect user input
IJ.log("-");
IJ.log("Waiting for user input...");
Dialog.create("Flamingo Converter v" + version);
Dialog.addMessage(lengthOf(list_stacks) + " " + fileformat + " stacks detected in " + path + ".");
Dialog.addMessage(nr_samples + " samples, " + nr_timepoints + " timepoints, " + nr_views + " views, " + nr_regions + " regions, " + nr_tileX + "x" + nr_tileY + " tiles, " + nr_channels + " channels, " + nr_illuminations + " illumination sides, " + nr_cameras + " detection sides.");
if (fileformat == "raw") {
	Dialog.addMessage("Provide image dimensions for raw files:");
	Dialog.addNumber("Image width:", 2048);
	Dialog.addNumber("Image height:", 2048);
}
Dialog.addMessage("Enter details of your imaging experiment:");
Dialog.addNumber("Detection magnification:", 10);
Dialog.addNumber("Camera pixel size (µm):", 6.5);
if (nr_timepoints > 1) {
	Dialog.addNumber("Timelapse interval:", 30);	
	list_interval = newArray("sec","min","h");
	Dialog.addChoice("sec/min/h", list_interval, "sec");
}
Dialog.addMessage("Select output options:");
Dialog.addCheckbox("Save stack", false);
Dialog.addCheckbox("Save projection", true);
Dialog.addCheckbox("Save preview", true);
Dialog.addMessage("Select preview options (if applicable):");
list_previewscale = newArray("1.00","0.75","0.50","0.25","0.10");
Dialog.addChoice("Output scale", list_previewscale, "0.25");
if (nr_timepoints > 1) {
	Dialog.addNumber("Frame rate (fps)", 5);
}
for (i=0; i<5; i++) {
	if (channels_used[i] == true) {
		Dialog.addChoice(default_channels[i] + " (Channel " + i+1 + ")", list_luts, default_luts[i]);
	}
}
Dialog.addCheckbox("Add scale bar", true);
if (nr_timepoints > 1) {
	Dialog.addCheckbox("Add time stamp", true);
}
Dialog.addMessage("Click OK when ready to proceed.");
Dialog.addHelp("https://involv3d.org/flamingo");
Dialog.show();

//save user input
if (fileformat == "raw") {
	image_width = Dialog.getNumber();
	image_height = Dialog.getNumber();
}
details_magnification = Dialog.getNumber();
details_pixelsize = Dialog.getNumber();
if (nr_timepoints > 1) {
	details_interval = Dialog.getNumber();
	details_interval_scale = Dialog.getChoice();
}
check_tif = Dialog.getCheckbox();
check_projection = Dialog.getCheckbox();
check_preview = Dialog.getCheckbox();
luts_selected = newArray(nr_channels);
preview_scale = parseFloat(Dialog.getChoice);
if (nr_timepoints > 1) {
	preview_framerate = Dialog.getNumber();
}
for (i=0; i<nr_channels; i++) {
	luts_selected[i] = Dialog.getChoice();
}
check_scalebar = Dialog.getCheckbox();
if (nr_timepoints > 1) {
	check_timestamp = Dialog.getCheckbox();
}

//set batch mode to prevent windows from opening
setBatchMode(true);

//read each file and save
if (check_tif == true) {
	File.makeDirectory(path + "_tif");
}
if (check_projection == true) {
	File.makeDirectory(path + "_projection");
}
if (check_preview == true) {
	File.makeDirectory(path + "_preview");
	File.makeDirectory(path + "_preview/temp1");
	File.makeDirectory(path + "_preview/temp2");
}

//loop over list_stacks
IJ.log("-");
IJ.log("Processing stacks...");
for (a = 0; a<lengthOf(list_stacks); a++) {
	//open 1 or 2 stacks depending on number of illumination sides
	if (nr_illuminations == 2) {
		if (fileformat == "tif") {
			open(path + list_stacks[a]);
		} else {
			run("Raw...", "open=[" + path + list_stacks[a] + "] image=[16-bit Unsigned] width=[" + image_width + "] height=[" + image_height + "] number=[100000] little-endian");
		}
		rename("I0");
		a++;
		if (fileformat == "tif") {
			open(path + list_stacks[a]);
		} else {
			run("Raw...", "open=[" + path + list_stacks[a] + "] image=[16-bit Unsigned] width=[" + image_width + "] height=[" + image_height + "] number=[100000] little-endian");
		}
		rename("I1");
		//blend illumination sides
		if (tif_channel[a] == 4) {
			imageCalculator("Min create stack", "I0","I1");
		} else {
			imageCalculator("Max create stack", "I0","I1");
		}
		memory = IJ.freeMemory();
		IJ.log("Processed stack " + (a-1)/2+1 + "/" + lengthOf(list_stacks)/2 + " using " + memory + "...");
		selectWindow("I0");
		close;
		selectWindow("I1");
		close;
	} else {
		if (fileformat == "tif") {
			open(path + list_stacks[a]);
		} else {
			run("Raw...", "open=[" + path + list_stacks[a] + "] image=[16-bit Unsigned] width=[" + image_width + "] height=[" + image_height + "] number=[100000] little-endian");
		}
		memory = IJ.freeMemory();
		IJ.log("Processed stack " + a+1 + "/" + lengthOf(list_stacks) + " using " + memory + ".");
	}
	//save stack if option selected
	if (check_tif == true) {
		saveAs("Tiff", path + "_tif/" + list_stacks[a]);
	}
	//save projection if option selected
	if (check_projection == true) {
		if (tif_channel[a] == 4) {
			run("Z Project...", "projection=[Min Intensity]");
		} else {
			run("Z Project...", "projection=[Max Intensity]");
		}
		saveAs("Tiff", path + "_projection/" + list_stacks[a]);
		close();
	}
	//save preview if option selected
	if (check_preview == true) {
		if (tif_channel[a] == 4) {
			run("Z Project...", "projection=[Min Intensity]");
		} else {
			run("Z Project...", "projection=[Max Intensity]");
		}
		//resize max projection
		getDimensions(getwidth, getheight, getchannels, getslices, getframes);
		run("Set Scale...", "distance=1 known=" + details_pixelsize / details_magnification + " unit=µm");
		run("Size...", "width=" + getwidth * preview_scale + " constrain average interpolation=Bilinear");
		//auto-enhance contrast
		run("Enhance Local Contrast (CLAHE)", "blocksize=127 histogram=256 maximum=3 mask=*None* fast_(less_accurate)");
		run("Enhance Contrast...", "saturated=0.1 normalize");
		// convert to 8-bit
		run("8-bit");
		//save frame
		saveAs("Tiff", path + "_preview/temp1/" + list_stacks[a]);
		close;
	}
	close();
}

//concatenate preview if preview option selected
IJ.log("-");
IJ.log("Concatenating preview...");
if (check_preview == true){
	//get list of preview files
	list_files = getFileList(path + "_preview/temp1");
	list_preview = newArray;
	count_stacks = 0;
	for (a = 0; a < list_files.length; a++) {
		filename = list_files[a];
		if (lengthOf(filename) == 54) {
			if (endsWith(filename, ".tif")) {
				fileformat = "tif";
				list_preview[count_stacks] = filename;
				//increase stack count by 1
				count_stacks++;
			}
		}
	}
	//loop over timepoints
	for (i=0; i<lengthOf(list_preview); i=i+nr_channels){
		for (k=0; k<nr_channels; k++) {
			path_open = path + "_preview/temp1/" + list_preview[i+k];
			open(path_open);
			rename(k);
			run(luts_selected[k]);
		}
		if (nr_channels == 2) {
			run("Merge Channels...", "c1=0 c2=1 create");
			run("Stack to RGB");
		}
		if (nr_channels == 3) {
			run("Merge Channels...", "c1=0 c2=1 c3=2 create");
			run("Stack to RGB");
		}
		if (nr_channels == 4) {
			run("Merge Channels...", "c1=0 c2=1 c3=2 c4=3 create");
			run("Stack to RGB");
		}
		if (nr_channels == 5) {
			run("Merge Channels...", "c1=0 c2=1 c3=2 c4=3 c5=4 create");
			run("Stack to RGB");
		}
		saveAs("Tiff", path + "_preview/temp2/" + list_preview[i]);
		close();
		for (k=0; k<nr_channels; k++) {
			//close();
		}
	}
	//generate separate movies
	nr_movies = nr_samples * nr_views * nr_regions * nr_tileX * nr_tileY * nr_cameras;
	count_movies = 0;
	for (i=0; i<nr_movies+1; i=i+nr_movies) {
		count_movies++;
		run("Image Sequence...", "open=[" + path + "_preview/temp2/" + "] starting=[" + count_movies + "] increment=[" + nr_movies + "] sort");
		run("RGB Color");
		//add scale bar if option selected
		if (check_scalebar == true) {
			run("Scale Bar...", "width=" + 10 * round(2000 / details_magnification / 10) + " height=" + 8 * preview_scale + " color=White background=None location=[Lower Right] hide label");		
		}
		//add time stamp if option selected
		if (check_timestamp == true) {
			run("Colors...", "foreground=white");
			run("Label...", "format=0 starting=0 interval=" + details_interval + " x=10 y=" + 120 * preview_scale + " font=" + 80 * preview_scale + " text=" + details_interval_scale);
			run("AVI... ", "compression=JPEG frame=" + preview_framerate + " save=[" + path + "_preview/preview_" + count_movies + ".avi" + "]");
			close();
		}
	}
}

//get date and time
getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
TimeString = DayNames[dayOfWeek]+"-";
if (dayOfMonth<10) {TimeString = TimeString+"0";}
TimeString = TimeString+dayOfMonth+"-"+MonthNames[month]+"-"+year+"_";
if (hour<10) {TimeString = TimeString+"0";}
TimeString = TimeString+hour;
if (minute<10) {TimeString = TimeString+"0";}
TimeString = TimeString+minute;
if (second<10) {TimeString = TimeString+"0";}
TimeString = TimeString+second;

//finish up
IJ.log("-");
IJ.log("Processing completed.");
IJ.log(TimeString);
IJ.log("---");
selectWindow("Log");
saveAs("Text", path + "FlamingoConverter_log_" + TimeString + ".txt");
