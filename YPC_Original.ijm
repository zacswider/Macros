//start with three split channels, threshold each to their final display range.  
//rename each channel "cyan", "yellow", or "magenta" respectively.  press 'Run'

selectWindow("cyan");
run("Grays");
run("Apply LUT");
selectWindow("yellow");
run("Grays");
run("Apply LUT");
selectWindow("magenta");
run("Grays");
run("Apply LUT");
/////////////////////////
imageCalculator("Max create stack", "cyan","yellow");
selectWindow("Result of cyan");
rename("green");
imageCalculator("Max create stack", "yellow","magenta");
selectWindow("Result of yellow");
rename("red");
imageCalculator("Max create stack", "magenta","cyan");
selectWindow("Result of magenta");
rename("blue");
run("Merge Channels...", "c1=red c2=green c3=blue create ignore");




