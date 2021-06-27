

% Inputs
% 1) V3Vgrid    - structure file with grid info
% 2) Cam        - camera to plot
%                   1=L; 2=R; 3=T; 4=B
%                   []=plot all four with subplots
% 3) Img        - image to plot
% 4) plotver    - version of plot desired
%                   1= just raw p2d
%                   2= raw p2d + 3 control points (fid; top; right)
%                   3= raw p2d + located points on the grid
% 5) button     - activate button for identification of grid points?
%                   0=no; 1=yes

function [] = PlotGrid(V3Vgrid,Cam,Img,plotver,button)

if ~isempty(Cam)    % single camera plot version
    
    if      Cam == 1 % L
        Xp2d        = V3Vgrid.camL(Img).Xp2d;
        Yp2d        = V3Vgrid.camL(Img).Yp2d;
        ctrlIdx     = V3Vgrid.camL(Img).ctrlIdx; 
        Xc          = V3Vgrid.camL(Img).Xc;
        Yc          = V3Vgrid.camL(Img).Yc;
        p2dIdx      = V3Vgrid.camL(Img).p2dIdx;
        titletext = ['Camera L - Image ' num2str(Img)];
    elseif  Cam == 2 % R
        Xp2d        = V3Vgrid.camR(Img).Xp2d;
        Yp2d        = V3Vgrid.camR(Img).Yp2d;
        ctrlIdx     = V3Vgrid.camR(Img).ctrlIdx; 
        Xc          = V3Vgrid.camR(Img).Xc;
        Yc          = V3Vgrid.camR(Img).Yc;
        p2dIdx      = V3Vgrid.camR(Img).p2dIdx;
        titletext = ['Camera R - Image ' num2str(Img)];
    elseif  Cam == 3 % T
        Xp2d        = V3Vgrid.camT(Img).Xp2d;
        Yp2d        = V3Vgrid.camT(Img).Yp2d;
        ctrlIdx     = V3Vgrid.camT(Img).ctrlIdx; 
        Xc          = V3Vgrid.camT(Img).Xc;
        Yc          = V3Vgrid.camT(Img).Yc;
        p2dIdx      = V3Vgrid.camT(Img).p2dIdx;
        titletext = ['Camera T - Image ' num2str(Img)];
    elseif  Cam == 4 % B
        Xp2d        = V3Vgrid.camB(Img).Xp2d;
        Yp2d        = V3Vgrid.camB(Img).Yp2d;
        ctrlIdx     = V3Vgrid.camB(Img).ctrlIdx;
        Xc          = V3Vgrid.camB(Img).Xc;
        Yc          = V3Vgrid.camB(Img).Yc;
        p2dIdx      = V3Vgrid.camB(Img).p2dIdx;
        titletext = ['Camera B - Image ' num2str(Img)];
    end
    
    figure('Position',[100 100 700 600]);
    h = plot(Xp2d,Yp2d,'.'); hold on; % grid points

    daspect([1 1 1]); set(gca,'Ydir','reverse')
    xlim([0 4096]); ylim([0 3072]);
    xlabel('X (px)'); ylabel('Y (px)');
    title(titletext);
    
    if button == 1
        h.ButtonDownFcn = @showIdx;
    end
    
    if      plotver == 2 % add control points
        hold on; 
        plot(Xp2d(ctrlIdx(1)),Yp2d(ctrlIdx(1)),'rs');
        plot(Xp2d(ctrlIdx(2)),Yp2d(ctrlIdx(2)),'bo');
        plot(Xp2d(ctrlIdx(3)),Yp2d(ctrlIdx(3)),'kd');
        legend('p2d','fid','top','right'); 
    elseif  plotver == 3 % add identified points
        hold on;
        plot(Xc(~isnan(p2dIdx)),Yc(~isnan(p2dIdx)),'ro');
        legend('p2d','identified points'); 
    end
else   % all four cameras plot version   

        Xp2d1        = V3Vgrid.camL(Img).Xp2d;
        Yp2d1        = V3Vgrid.camL(Img).Yp2d;
        ctrlIdx1     = V3Vgrid.camL(Img).ctrlIdx; 
        Xc1          = V3Vgrid.camL(Img).Xc;
        Yc1          = V3Vgrid.camL(Img).Yc;
        p2dIdx1      = V3Vgrid.camL(Img).p2dIdx;
        
        Xp2d2        = V3Vgrid.camR(Img).Xp2d;
        Yp2d2        = V3Vgrid.camR(Img).Yp2d;
        ctrlIdx2     = V3Vgrid.camR(Img).ctrlIdx; 
        Xc2          = V3Vgrid.camR(Img).Xc;
        Yc2          = V3Vgrid.camR(Img).Yc;
        p2dIdx2      = V3Vgrid.camR(Img).p2dIdx;

        Xp2d3        = V3Vgrid.camT(Img).Xp2d;
        Yp2d3        = V3Vgrid.camT(Img).Yp2d;
        ctrlIdx3     = V3Vgrid.camT(Img).ctrlIdx; 
        Xc3          = V3Vgrid.camT(Img).Xc;
        Yc3          = V3Vgrid.camT(Img).Yc;
        p2dIdx3      = V3Vgrid.camT(Img).p2dIdx;

        Xp2d4        = V3Vgrid.camB(Img).Xp2d;
        Yp2d4        = V3Vgrid.camB(Img).Yp2d;
        ctrlIdx4     = V3Vgrid.camB(Img).ctrlIdx;
        Xc4          = V3Vgrid.camB(Img).Xc;
        Yc4          = V3Vgrid.camB(Img).Yc;
        p2dIdx4      = V3Vgrid.camB(Img).p2dIdx;
        
    figure('Position',[50 50 1050 750])
    
    subplot(2,2,1);
    plot(Xp2d1,Yp2d1,'.'); daspect([1 1 1]); set(gca,'Ydir','reverse')
    xlim([0 4096]); ylim([0 3072]); xlabel('X (px)'); ylabel('Y (px)');
    title('Left camera');
    if      plotver == 2 % add control points
        hold on; 
        plot(Xp2d1(ctrlIdx1(1)),Yp2d1(ctrlIdx1(1)),'rs');
        plot(Xp2d1(ctrlIdx1(2)),Yp2d1(ctrlIdx1(2)),'bo');
        plot(Xp2d1(ctrlIdx1(3)),Yp2d1(ctrlIdx1(3)),'kd');
        legend('p2d','fid','top','right'); 
    elseif  plotver == 3 % add identified points
        hold on;
        plot(Xc1(~isnan(p2dIdx1)),Yc1(~isnan(p2dIdx1)),'ro');
        legend('p2d','identified points'); 
    end
    
    subplot(2,2,3);
    plot(Xp2d2,Yp2d2,'.'); daspect([1 1 1]); set(gca,'Ydir','reverse')
    xlim([0 4096]); ylim([0 3072]); xlabel('X (px)'); ylabel('Y (px)');
    title('Right camera');
    if      plotver == 2 % add control points
        hold on; 
        plot(Xp2d2(ctrlIdx2(1)),Yp2d2(ctrlIdx2(1)),'rs');
        plot(Xp2d2(ctrlIdx2(2)),Yp2d2(ctrlIdx2(2)),'bo');
        plot(Xp2d2(ctrlIdx2(3)),Yp2d2(ctrlIdx2(3)),'kd');
        legend('p2d','fid','top','right'); 
    elseif  plotver == 3 % add identified points
        hold on;
        plot(Xc2(~isnan(p2dIdx2)),Yc2(~isnan(p2dIdx2)),'ro');
        legend('p2d','identified points'); 
    end
    
    subplot(2,2,2);
    plot(Xp2d3,Yp2d3,'.'); daspect([1 1 1]); set(gca,'Ydir','reverse')
    xlim([0 4096]); ylim([0 3072]); xlabel('X (px)'); ylabel('Y (px)');
    title('Top camera');
    if      plotver == 2 % add control points
        hold on; 
        plot(Xp2d3(ctrlIdx3(1)),Yp2d3(ctrlIdx3(1)),'rs');
        plot(Xp2d3(ctrlIdx3(2)),Yp2d3(ctrlIdx3(2)),'bo');
        plot(Xp2d3(ctrlIdx3(3)),Yp2d3(ctrlIdx3(3)),'kd');
        legend('p2d','fid','top','right'); 
    elseif  plotver == 3 % add identified points
        hold on;
        plot(Xc3(~isnan(p2dIdx3)),Yc3(~isnan(p2dIdx3)),'ro');
        legend('p2d','identified points'); 
    end
    
    subplot(2,2,4);
    plot(Xp2d4,Yp2d4,'.'); daspect([1 1 1]); set(gca,'Ydir','reverse')
    xlim([0 4096]); ylim([0 3072]); xlabel('X (px)'); ylabel('Y (px)');
    title('Bottom camera');
    if      plotver == 2 % add control points
        hold on; 
        plot(Xp2d4(ctrlIdx4(1)),Yp2d4(ctrlIdx4(1)),'rs');
        plot(Xp2d4(ctrlIdx4(2)),Yp2d4(ctrlIdx4(2)),'bo');
        plot(Xp2d4(ctrlIdx4(3)),Yp2d4(ctrlIdx4(3)),'kd');
        legend('p2d','fid','top','right'); 
    elseif  plotver == 3 % add identified points
        hold on;
        plot(Xc4(~isnan(p2dIdx4)),Yc4(~isnan(p2dIdx4)),'ro');
        legend('p2d','identified points'); 
    end
end                 

end % function end

% This function modified from the code given in 
%  https://www.mathworks.com/matlabcentral/answers/475853-how-to-enable-a-figure-so-that-if-i-click-on-a-point-and-it-will-show-the-value

function [coordinateSelected, minIdx] = showIdx(hObj, event)
%  FIND NEAREST (X,Y,Z) COORDINATE TO MOUSE CLICK
% Inputs:
%  hObj (unused) the axes
%  event: info about mouse click
% OUTPUT
%  coordinateSelected: the (x,y,z) coordinate you selected
%  minIDx: The index of your inputs that match coordinateSelected. 
x = hObj.XData; 
y = hObj.YData; 
pt = event.IntersectionPoint;       % The (x0,y0,z0) coordinate you just selected
coordinates = [x(:),y(:)];     % matrix of your input coordinates
dist = pdist2(pt(1:2),coordinates);      %distance between your selection and all points
[~, minIdx] = min(dist);            % index of minimum distance to points
coordinateSelected = coordinates(minIdx,:); %the selected coordinate

disp(['Idx = ' num2str(minIdx)]);
end % <--- optional if this is embedded into a function