Author: Micah A. Wyssmann
Date:   6/27/2021

Purpose of PIVCal3D: This code takes inputs of identified grid points and determines the 'world' grid locations. This information can then be used to generate calibration polynomials mapping from camera to world coordinates (and vice versa) for a volumetric particle image velocimetry (PIV) system.

Software compatability:
- Inputs of grid points are taken from the files generated in the TSI InsightV3V(TM) 4G software
- Compatibility has only been tested for files generated with InsightV3V(TM) 4G version 4.0.3.0 

Volumetric PIV system details this code is written for:
- Four 12 MP cameras
- TSI(TM) backlit calibration target with 5 mm dot spacing

Required inputs:
- '*.p2d' files generated in TSI InsightV3V(TM) 4G software during "Particle Identification"

Outputs:
- The 'V3Vgrid' structure file contains the camera coordinates (Xc,Yc) for the points that were identified to correspond with the precise grid locations on the calibration target. 

Instructions:
- Before using this script, you must first: capture calibration images; pre-process the images as needed; process the images for the "Particle Identification"
- Everything you need to do is carried out in one driver MATLAB script: 'PIVCal3D_dr.m'. This script calls other functions in the toolbox as appropriate and is broken into multiple sections.
- To use the toolbox: open PIVCal3D_dr.m, read instructions, and run each section successively using the 'Run Section' button in MATLAB. Make sure to evaluate results after the steps as necessary.
- Note that this toolbox requires that three points are manually identified with clicks in the first two calibration images. The points that must be identified are: (1) the fiducial mark; (2) the point directly above the fiducial mark; and (3) the point directly to the right of the fiducial mark. When you click 'Run Section' for 'Step 2', a figure will automatically pop up with cross hairs. Do not click anywhere but on the 3 control points (in the order listed above). After you click the 3 points for one image, that figure window will close and the next image will pull up in the same way. This will proceed until all control points are appropriately identified for the 2 first image sets. After completing these clicks, figures will pop up showing the points you identified. Make sure they are correct before proceeding. You can re-run 'Step 2' as many times as needed if you have an error.

Test data provided:
- Example 'V3Vgrid' structure files are provided from two steps: (1) after step 1; and (2) after step 4. The former can be loaded to test the code if you do not have '*.p2d' files of your own. The latter shows the outputs of the code after running Steps 1-4.

