
titles = getList("image.titles");
output="/Volumes/FlashSSD/211217_Live_Flvw_Ocyte_SsrA-mV-CAAX_mCh-wGBD/0_Analysis/Ect2_intDen"
for (i=0; i<titles.length; i++){
	selectWindow(titles[i]);
	name = getTitle();
	dotIndex = indexOf(name, ".");
	nameWithoutExtension =  substring(name, 0, dotIndex);
	run("Set Measurements...", "integrated redirect=None decimal=3");
	run("Select All");
	run("Clear Results");
	run("Plot Z-axis Profile");
	Plot.getValues(x, wGBD_intDen);
	close();
	Array.show("multichannel technical analysis oohhhhhh", wGBD_intDen);
	print("Saving to: " + output);
	saveAs("Results", output + "/" + nameWithoutExtension + ".csv");
	run("Close");
}