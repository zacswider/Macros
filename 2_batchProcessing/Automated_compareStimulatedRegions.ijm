
run("Set Measurements...", "mean redirect=None decimal=3"); // set appropriate measurements
fileName = getInfo("image.filename") ;  //saves image name for future use
dotIndex = indexOf(fileName, ".");  	//this and the following line get the file name without the extension
fileNameWithoutExtension = substring(fileName, 0, dotIndex); //this and the above line get the file name without the extension

titles = getList("image.titles");

for (i=0; i<titles.length; i++){
	setSlice(1);
	makeRectangle(291, 158, 211, 212); // ROI
	getStatistics(area, prestim_ROI_mean, min, max, std, histogram)
	makeRectangle(31, 155, 211, 212);  // Control
	getStatistics(area, prestim_cntrl_mean, min, max, std, histogram)
	
	setSlice(2);
	makeRectangle(291, 158, 211, 212); // ROI
	getStatistics(area, poststim_ROI_mean, min, max, std, histogram)
	makeRectangle(31, 155, 211, 212);  // Control
	getStatistics(area, poststim_cntrl_mean, min, max, std, histogram)
	
	prestim_ratio = (prestim_ROI_mean / prestim_cntrl_mean);
	poststim_ratio = (poststim_ROI_mean / poststim_cntrl_mean);
	pcnt_increase =  (((poststim_ratio - prestim_ratio)/prestim_ratio)*100); // percent of original
	
	print(fileNameWithoutExtension);
	print(pcnt_increase);
}