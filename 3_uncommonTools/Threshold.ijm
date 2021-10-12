fileName = getInfo("image.filename") ; 
//saves image name for future use
dotIndex = indexOf(fileName, ".");  
//this and the following line get the file name without the extension
fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
//this and the above line get the file name without the extension
run("Duplicate...", "title=blurThisImage duplicate");
run("Gaussian Blur...", "sigma=32 stack");
run("Multiply...", "value=0.8 stack");
imageCalculator("Divide create 32-bit stack", fileName,"blurThisImage");
selectWindow("blurThisImage");
close();
selectWindow("Result of " + fileName);
rename(fileNameWithoutExtension + "-FFCorr.tif");
run("Enhance Contrast", "saturated=0.35");
waitForUser("Crop the image", "Do you want to crop your image before proceeding? If so, make a selection now.")
run("Crop");
run("Threshold...");
run("Make Binary", "method=Default background=Default calculate black");
run("Fill Holes", "stack");
run("Erode", "stack");
run("Dilate", "stack");
run("Analyze Particles...", "size=100-Infinity pixel show=Overlay display clear stack");