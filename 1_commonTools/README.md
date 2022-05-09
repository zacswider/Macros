### Background

*diffMC.ijm*  
This macro uses the currently active image to calculate the difference movie, also known as a *temporal derivative movie*. In brief, the program will request a number (*n*) of frames to compare from the user, it will then calculate a rolling difference between *n* frames for the duration of the time series and return all difference values greater than zero. The currently active image must have multiple time points and may also have multiple channels.

*resliceMC.ijm*  
This macro overcomes a bug in FIJI which prohibits the reslicing of multi-channel images. It does so by splitting a multi-channel image and reslicing each channel along the Z or T axis (whichever comes first), it then calculates a rolling average of n resliced frames (noise suppression), and recombines the channels.  

*setImageProperties.ijm*  
Be warned, this macro iterates through *all* open images. Depending on the number of channels in the active image it sets a use-defined pallete of lookup tables, auto-scales each channel according the user specifications, and saves the image. 
