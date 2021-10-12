fileName = getInfo("image.filename") ; 
//saves image name for future use
dotIndex = indexOf(fileName, ".");  
//this and the following line get the file name without the extension
fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
//this and the above line get the file name without the extension

path = "/Users/bementmbp/Desktop/fftStack/";

for (i=1; i<=nSlices; i++) {
	selectWindow(fileName);
    setSlice(i);
    run("FFT");
    saveAs("Tiff", path+i+"_"+fileName);
    close();
}

run("Image Sequence...", "select="+path+" "+path+" sort");