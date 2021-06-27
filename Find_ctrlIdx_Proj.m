
% clearvars -except V3Vgrid

% Purpose: This function tages V3Vgrid input with only the first 2 images
% having control points identified (fid mark, above it, right of it) and
% projects to all successive images to find these control points

% Inputs
% 1) V3Vgrid    - must have run Find_ctrlIdx_Auto.m on the first 2 images

% Outputs
% 1) V3Vgrid    - has ctrlIdx updated for all other images

function V3Vgrid = Find_ctrlIdx_Proj(V3Vgrid)

close all

nImg = numel(V3Vgrid.camL);

init = NaN(nImg,1); 
zvec = init;
for Img = 1:nImg
    zvec(Img,1) = V3Vgrid.camL(Img).z_mm;
end

for Cam = 1:4 % loop through all cameras later
    
    Xo = init; Yo = init; 
    Xt = init; Yt = init;
    Xr = init; Yr = init;    
    
    for Img = 1:nImg % pull data points from 
        if      Cam == 1 % L
            Xp2d    = V3Vgrid.camL(Img).Xp2d;
            Yp2d    = V3Vgrid.camL(Img).Yp2d;
            ctrlIdx = V3Vgrid.camL(Img).ctrlIdx;
        elseif  Cam == 2 % R
            Xp2d    = V3Vgrid.camR(Img).Xp2d;
            Yp2d    = V3Vgrid.camR(Img).Yp2d;
            ctrlIdx = V3Vgrid.camR(Img).ctrlIdx;
        elseif  Cam == 3 % T
            Xp2d    = V3Vgrid.camT(Img).Xp2d;
            Yp2d    = V3Vgrid.camT(Img).Yp2d;
            ctrlIdx = V3Vgrid.camT(Img).ctrlIdx;
        elseif  Cam == 4 % B
            Xp2d    = V3Vgrid.camB(Img).Xp2d;
            Yp2d    = V3Vgrid.camB(Img).Yp2d;
            ctrlIdx = V3Vgrid.camB(Img).ctrlIdx;
        end
        
        % Note to self
        % ctrlIdx = [fid mark, above fid mark, right of fid mark]
        
        if Img < 3 % these were manual so pull values
            Xo(Img) = Xp2d(ctrlIdx(1));
            Yo(Img) = Yp2d(ctrlIdx(1));
            Xt(Img) = Xp2d(ctrlIdx(2));
            Yt(Img) = Yp2d(ctrlIdx(2));
            Xr(Img) = Xp2d(ctrlIdx(3));
            Yr(Img) = Yp2d(ctrlIdx(3));
        else  % not manually clicked, so run iterative projections
            dzprev = zvec(Img-1) - zvec(Img-2);
            dzproj = zvec(Img)   - zvec(Img-1);
            dXodz = (Xo(Img-1) - Xo(Img-2))/dzprev; 
            dYodz = (Yo(Img-1) - Yo(Img-2))/dzprev; 
            dXtdz = (Xt(Img-1) - Xt(Img-2))/dzprev; 
            dYtdz = (Yt(Img-1) - Yt(Img-2))/dzprev; 
            dXrdz = (Xr(Img-1) - Xr(Img-2))/dzprev; 
            dYrdz = (Yr(Img-1) - Yr(Img-2))/dzprev;
            
            pto_proj = [Xo(Img-1)+dXodz*dzproj Yo(Img-1)+dYodz*dzproj];
                dist = pdist2([Xp2d Yp2d],pto_proj);      %distance between your selection and all points
                [~, minIdx] = min(dist); 
                ctrlIdx(1) = minIdx;
            ptt_proj = [Xt(Img-1)+dXtdz*dzproj Yt(Img-1)+dYtdz*dzproj];
                dist = pdist2([Xp2d Yp2d],ptt_proj);      %distance between your selection and all points
                [~, minIdx] = min(dist); 
                ctrlIdx(2) = minIdx;
            ptr_proj = [Xr(Img-1)+dXrdz*dzproj Yr(Img-1)+dYrdz*dzproj];
                dist = pdist2([Xp2d Yp2d],ptr_proj);      %distance between your selection and all points
                [~, minIdx] = min(dist); 
                ctrlIdx(3) = minIdx;
            
            % store projected ctrlIdx in the loop vectors
            Xo(Img) = Xp2d(ctrlIdx(1));
            Yo(Img) = Yp2d(ctrlIdx(1));
            Xt(Img) = Xp2d(ctrlIdx(2));
            Yt(Img) = Yp2d(ctrlIdx(2));
            Xr(Img) = Xp2d(ctrlIdx(3));
            Yr(Img) = Yp2d(ctrlIdx(3));
                
            % store projected ctrlIdx into V3Vgrid
            if      Cam == 1 % L
                V3Vgrid.camL(Img).ctrlIdx = ctrlIdx;
            elseif  Cam == 2 % R
                V3Vgrid.camR(Img).ctrlIdx = ctrlIdx;
            elseif  Cam == 3 % T
                V3Vgrid.camT(Img).ctrlIdx = ctrlIdx;
            elseif  Cam == 4 % B
                V3Vgrid.camB(Img).ctrlIdx = ctrlIdx;
            end
            
        end % if/else statement for read/project
        
    end % Img loop
end % Cam loop

% plot to check
for Img = 1:nImg
    PlotGrid(V3Vgrid,[],Img,2,0);
end

end