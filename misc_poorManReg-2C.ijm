makeRectangle(229, 0, 246, 512);
run("Crop");
run("Re-order Hyperstack ...", "channels=[Slices (z)] slices=[Channels (c)] frames=[Frames (t)]");
run("PoorMan3DReg ", "transformation=Translation number=3 projection=[Max Intensity]");
run("Re-order Hyperstack ...", "channels=[Slices (z)] slices=[Channels (c)] frames=[Frames (t)]");
