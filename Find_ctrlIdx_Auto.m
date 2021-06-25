
% Purpose: This function generates a plot and asks you to click three
% control points. Based on the 3 clicks, it finds the indices for these
% points and saves them into the V3Vgrid structure file.

% Inputs
% 1) V3Vgrid    - initialized V3Vgrid structure file
% 2) Cam        - camera
%                    1=L; 2=R; 3=T; 4=B
% 3) Img        - image number in the range of 1 and numel in V3Vgrid.camL
% 4) PlotCheck  - after clicking to find points, do you want a plot
%                   generated that lets you check the accuracy of 
%                   your clicks? 
%                   0=no; 1=yes
%                   Note: results are saved in V3Vgrid regardless

% Outputs
% 1) V3Vgrid    - same as input but updated with indices 
%                   in V3Vgrid.cam?(Img).ctrlIdx

function V3Vgrid = Find_ctrlIdx_Auto(V3Vgrid,Cam,Img,PlotCheck)

if      Cam == 1 % L
    Xp2d = V3Vgrid.camL(Img).Xp2d;
    Yp2d = V3Vgrid.camL(Img).Yp2d;
elseif  Cam == 2 % R
    Xp2d = V3Vgrid.camR(Img).Xp2d;
    Yp2d = V3Vgrid.camR(Img).Yp2d;
elseif  Cam == 3 % T
    Xp2d = V3Vgrid.camT(Img).Xp2d;
    Yp2d = V3Vgrid.camT(Img).Yp2d;
elseif  Cam == 4 % B
    Xp2d = V3Vgrid.camB(Img).Xp2d;
    Yp2d = V3Vgrid.camB(Img).Yp2d;
end

fig1 = figure('Position',[100 100 900 700]);
h = plot(Xp2d,Yp2d,'o'); hold on; % grid points

daspect([1 1 1]); set(gca,'Ydir','reverse')
xlim([0 4096]); ylim([0 3072]);
xlabel('X (px)'); ylabel('Y (px)');
title('Click fid mark, then above fid mark, then to right of fid mark. 3 clicks only! Accuracy doesnt need to be perfect, just close.')

[xvec,yvec] = ginput(3); % call for 3 clicks

ctrlIdx = zeros(1,3);
for i = 1:3
    dist = pdist2([Xp2d Yp2d],[xvec(i) yvec(i)]);      %distance between your selection and all points
    [~, minIdx] = min(dist); 
    ctrlIdx(i) = minIdx;
end

if      Cam == 1 % L
    V3Vgrid.camL(Img).ctrlIdx = ctrlIdx;
elseif  Cam == 2 % R
    V3Vgrid.camR(Img).ctrlIdx = ctrlIdx;
elseif  Cam == 3 % T
    V3Vgrid.camT(Img).ctrlIdx = ctrlIdx;
elseif  Cam == 4 % B
    V3Vgrid.camB(Img).ctrlIdx = ctrlIdx;
end

close(fig1);

if PlotCheck == 1
    PlotGrid(V3Vgrid,Cam,Img,2,0)
    title('Check accuracy of points you identified');
end

end