/*
 * Macro opens files, log processes then, and re-saves them
 */
 
#@ File (label = "Input directory", style = "directory") input
#@ String (label = "File suffix", value = ".tif") suffix

processFolder(input)

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		print(list[i]);
		if(File.isDirectory(input + File.separator + list[i])){
			print(list[i] + " is a directory");
		}
		if(endsWith(list[i], suffix)){
			processFile(input, list[i]);
		}
	}
}

function processFile(input, file) {
	// open stack and split the channels
	print("Opening " + input + "/" + file);
	open(input + "/" + file);
	// get the file name without the extension
	dotIndex = indexOf(file, "."); 
	if (dotIndex > 0) {
		fileNameWithoutExtension = substring(file, 0, dotIndex);
	} else {
		print("no dot index to parse...") ;
	}	
	run("Log");
	run("Save");
	close();
}






