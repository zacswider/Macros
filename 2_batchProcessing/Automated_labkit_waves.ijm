// ImageJ macro for segmenting a list of images
folder = "C:/path/to/folder/"
for (i = 0; i < 10; i++) {
   open(folder + "image_" + i + ".tif");
   run("Segment Image With Labkit", "segmenter_file=" + folder + "my_pretrained_classifier.classifier use_gpu=false");
   saveAs("Tiff", folder + "segmentation_" + i + ".tif");
   close();
   close();
}