while (nImages > 0) {

	
	fileName = getInfo("image.title"); 
	
	dotIndex = indexOf(fileName, "."); 
	
	fileNameWithoutExtension = substring(fileName, 0, dotIndex);
	
	run("Set Measurements...", "mean redirect=None decimal=3");
	run("Z Project...", "projection=[Min Intensity]");
	run("Clear Results");
	run("Measure");
	mean = getResult("Mean", 0);
	close("MIN_" + fileName);
	close(fileName);
	savePath = "/Users/bementmbp/Desktop/BementLab/2_Projects/29_tripleWavePaper/Figures/Figure02/Figure02a/files_to_analyze_background/";
	
	saveAs("Results", savePath + fileNameWithoutExtension + ".csv");
	run("Clear Results");


}









