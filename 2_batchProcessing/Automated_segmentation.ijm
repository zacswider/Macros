
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	path = getDirectory("image") ;
	//saves path that the image is saved to
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_otsu.tif" ;
	
	setAutoThreshold("Otsu");
	//setOption("BlackBackground", false);
	run("Convert to Mask", "method=Otsu background=Light calculate create");
	run("Analyze Particles...", "summarize stack");
	
	results_save_path = "/Users/bementmbp/Desktop/BementLab/2_Projects/29_tripleWavePaper/Figures/Figure03_waveArea/files_to_analyze_segmented_otsu/area_output/";
	csv_name = fileNameWithoutExtension + "_CSV.csv" ;
	saveAs("Results", results_save_path + csv_name);
	
	im_save_path = "/Users/bementmbp/Desktop/BementLab/2_Projects/29_tripleWavePaper/Figures/Figure03_waveArea/files_to_analyze_segmented_otsu/images/";
	selectWindow("MASK_" + fileName);
	saveAs("Tiff", im_save_path + newFileName);
	close(newFileName);
	close(csv_name);
	close(fileName);
	
}