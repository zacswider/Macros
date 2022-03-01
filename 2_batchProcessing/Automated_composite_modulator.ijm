
//get list of all open image windows
titles = getList("image.titles");

for (i=0; i<titles.length; i++){
		selectWindow(titles[i]);
		Stack.setDisplayMode("composite");
		//Stack.setDisplayMode("grayscale");
		Stack.setActiveChannels("11");
		//Stack.setChannel(2);
		//run("Enhance Contrast", "saturated=0.15");

}
