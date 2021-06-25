Purpose: This toolbox takes the input of *.p2d files of grid points identified in InsightV3V and generates the calibration file *.V3VCalib.
This code is needed where InsightV3V is unable to find the grid and calibrate (e.g., for steep camera angles relative to the grid). The code is only written for a four-camera system and for the TSI backlit target.

Instructions:
- Before using this script, you must first: (1) capture calibration images; (2) pre-process the images as needed; (3) process the images in InsightV3V with the first step in calibration processing (i.e., to find 2D points)
- Everything can be carried out using one script: V3VCal_dr.m 
- V3VCal_dr.m calls other functions as appropriate and is broken into multiple sections
- To develop a calibration, open V3VCal_dr.m, read instructions, and run each section successively using the "Run Section" button in MATLAB. Make sure to evaluate results after each step as necessary.
- Note that this toolbox requires that three points are manually identified with clicks in the first two calibration images. The points that must be identified are: (1) the fiducial mark; (2) the point directly above the fiducial mark; and (3) the point directly to the right of the fiducial mark.
- When you run "Step 5", the code will generate a plot of camera-to-world and world-to-camera errors similar to the plot generated in InsightV3V. This is the last and most important figure to evaluate and ensure that the calibration is of acceptable quality.
- When "Step 6" is run to export the calibration information, it will write a *.V3VCalib file into the directory where the *.p2d

Notes: 
- This code has only been tested with InsightV3V-4G version 4.0.3.0.
