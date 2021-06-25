

% Purpose: This pulls some simple info about the grid together for export
% in the eventual V3VCalib file. I simply didn't save this info earlier.

% clearvars -except V3Vgrid

function V3Vgrid = FindGridInfo(V3Vgrid)

nImg = numel(V3Vgrid.camL);

for Img = 1:nImg % do easy ones first
    V3Vgrid.camL(Img).XcOr  =            V3Vgrid.camL(Img).Xc(20,20);
    V3Vgrid.camL(Img).YcOr  =            V3Vgrid.camL(Img).Yc(20,20);
    V3Vgrid.camL(Img).nc    = sum(~isnan(V3Vgrid.camL(Img).p2dIdx(:)));
    
    V3Vgrid.camR(Img).XcOr  =            V3Vgrid.camR(Img).Xc(20,20);
    V3Vgrid.camR(Img).YcOr  =            V3Vgrid.camR(Img).Yc(20,20);
    V3Vgrid.camR(Img).nc    = sum(~isnan(V3Vgrid.camR(Img).p2dIdx(:)));
    
    V3Vgrid.camT(Img).XcOr  =            V3Vgrid.camT(Img).Xc(20,20);
    V3Vgrid.camT(Img).YcOr  =            V3Vgrid.camT(Img).Yc(20,20);
    V3Vgrid.camT(Img).nc    = sum(~isnan(V3Vgrid.camT(Img).p2dIdx(:)));
    
    V3Vgrid.camB(Img).XcOr  =            V3Vgrid.camB(Img).Xc(20,20);
    V3Vgrid.camB(Img).YcOr  =            V3Vgrid.camB(Img).Yc(20,20);
    V3Vgrid.camB(Img).nc    = sum(~isnan(V3Vgrid.camB(Img).p2dIdx(:)));
end

for Img = 1:nImg
    for Cam = 1:4
        if      Cam == 1 % L
            Xc1 = V3Vgrid.camL(Img).Xc(20,20);
            Yc1 = V3Vgrid.camL(Img).Yc(20,20);
            Xc2 = V3Vgrid.camL(Img).Xc(21,20);
            Yc2 = V3Vgrid.camL(Img).Yc(21,20);
        elseif  Cam == 2 % R
            Xc1 = V3Vgrid.camR(Img).Xc(20,20);
            Yc1 = V3Vgrid.camR(Img).Yc(20,20);
            Xc2 = V3Vgrid.camR(Img).Xc(21,20);
            Yc2 = V3Vgrid.camR(Img).Yc(21,20);
        elseif  Cam == 3 % T
            Xc1 = V3Vgrid.camT(Img).Xc(20,20);
            Yc1 = V3Vgrid.camT(Img).Yc(20,20);
            Xc2 = V3Vgrid.camT(Img).Xc(21,20);
            Yc2 = V3Vgrid.camT(Img).Yc(21,20);
        elseif  Cam == 4 % B
            Xc1 = V3Vgrid.camB(Img).Xc(20,20);
            Yc1 = V3Vgrid.camB(Img).Yc(20,20);
            Xc2 = V3Vgrid.camB(Img).Xc(21,20);
            Yc2 = V3Vgrid.camB(Img).Yc(21,20);
        end
        
        dXc = abs(Xc1 - Xc2);
        dYc = abs(Yc1 - Yc2); 
        dR = (dXc.^2 + dYc.^2).^0.5;
        
        if      Cam == 1 % L
            V3Vgrid.camL(Img).GrdSpc = dR;
        elseif  Cam == 2 % R
            V3Vgrid.camR(Img).GrdSpc = dR;
        elseif  Cam == 3 % T
            V3Vgrid.camT(Img).GrdSpc = dR;
        elseif  Cam == 4 % B
            V3Vgrid.camB(Img).GrdSpc = dR;
        end
    end
end
    
end