

%% DIRECTIONS

% This script file has multiple steps (listed below). Run each section
% successively and evaluate the results as needed.

% STEPS FOR CALIBRATION CONTAINED HEREIN
% 1) Open directory and select *.p2d files in the InsightV3V(TM) directory
% 2) Manually click control points around fiducial mark in images 1 & 2
%   (and confirm quality)
% 3) Run function that projects control points to other images (and confirm
%   quality) 
% 4) Call the function that finds all grid points and assigns their
% locations

% GENERAL NOTES
% - To run a section, place your cursor in the section so that it lights 
% up yellow, then click "Run Section" button in Matlab editor tab
% - Step 4 requires some manual inputs, which are listed at the
% top of the code section. Change these variables to desired values before 
% running the section.

%% Step 1: Open directory and initialize structure file

[filenames, pathname, ~] = ...
    uigetfile({'*.p2d*'},'File Selector','MultiSelect','on');

V3Vgrid = V3Vgrid_Init(filenames,pathname);

% find name of experiment folder
loc_Sl      = strfind(pathname,'\');
loc_CalFold = strfind(pathname,'\V3V Calibration');

loc_end     = find(loc_Sl == loc_CalFold);  n_end = loc_Sl(loc_end)-1;
loc_beg     = loc_end-1;                    n_beg = loc_Sl(loc_beg)+1;

expname     = pathname(n_beg:n_end); 

V3Vgrid.expname = expname; 

clearvars loc_Sl loc_CalFold loc_end loc_beg n_end n_beg

disp('FINISHED STEP 1: Initialize');

%% Step 2: Click to find control points for first 2 images (and confirm accuracy)

close all;
CamNames = {'CamL','CamR','CamT','CamB'};
for Cam = 1:4
    for Img = 1:2
        V3Vgrid = Find_ctrlIdx_Auto(V3Vgrid,Cam,Img,0);
        disp(['Finished ' CamNames{Cam} ', Image ' num2str(Img)])
    end
end

close all;
for Img = 1:2
    PlotGrid(V3Vgrid,[],Img,2,0);
end

disp('FINISHED STEP 2: Click for control points in images 1 & 2');

%% Step 3: Project to find others in all subsequent images and make sure correct

close all;
V3Vgrid = Find_ctrlIdx_Proj(V3Vgrid);

disp('FINISHED STEP 3: Project control points for successive images');

%% Step 4: Call 'FindGrid_ALL.m' to find grids based on ctrl points

% ---------- Variables to change ------------------
xgrlims = []; % manual x limits of grid points you want to consider
ygrlims = []; % manual y limits of grid points you want to consider
Plot = 0;     % Generate plots? 1=yes; 0=no

% NOTES: 
%   - It is perfectly ok and normal to leave xgrlims and ygrlims empty
%   - If this option is used, values are referenced to fiducial mark and
%   absolute values of limits must be <= 95, which is the coordinate of
%   the outermost grid points (there are 39 grid rows/columns at 5 mm
%   spacing)
% -------------------------------------------------

% 4a: find the grid from 3 ctrl pts
V3Vgrid = FindGrid_ALL(V3Vgrid);   

% 4b: trim the data
V3Vgrid = GridTrimMed(V3Vgrid); % median based automatic trimming
V3Vgrid = GridTrimManual(V3Vgrid,xgrlims,ygrlims); % manual trimming

% 4c: get some final info
V3Vgrid = FindGridInfo(V3Vgrid);  

% 4d: Plot and check through the planes to make sure results look correct
plotver = 3; % typically just use 3 (plot identified grid points) 
%   Could also use 2 just to check control points again if suspect an error
if Plot == 1
    close all;
    for Img = 1:numel(V3Vgrid.camL)
        PlotGrid(V3Vgrid,[],Img,plotver,0);
    end
end

disp('FINISHED STEP 4: Find grid points and plot. Make sure it looks right!');
