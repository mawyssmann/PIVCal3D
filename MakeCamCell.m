
% clearvars -except V3VCalib

function CellOut = MakeCamCell(V3VCalibCam,Cam)

% % ---- Inputs to this eventual function -----------------
% V3VCalibCam = V3VCalib.camR;
% Cam = 0;
% % -------------------------------------------------------

nImg = length(V3VCalibCam.Z_mm);
Zmin = min(V3VCalibCam.Z_mm);
Zmax = max(V3VCalibCam.Z_mm);

% Row 1 - camera and basic info
if      Cam == 0 % R
    C{1,1} = 'Aperture=0,';
elseif  Cam == 1 % L
    C{1,1} = 'Aperture=1,';
elseif  Cam == 2 % T
    C{1,1} = 'Aperture=2,';
elseif  Cam == 3 % B
    C{1,1} = 'Aperture=3,';
end
C{1,2} = 'ImageWidth_pix=4096,ImageHeight_pix=3072,xPixDim_micron=5.5,yPixDim_micron=5.5,GridSpacing_mm=5,NumValidImages=';
C{1,3} = num2str(nImg);
C{1,4} = ',zMin_mm=';       C{1,5} = num2str(Zmin);
C{1,6} = ',zMax_mm=';       C{1,7} = num2str(Zmax);
C{1,8} = ',';

% Row 2 - grid settings (basically never change for this setup)
C{2,1}  = 'IsDualPlane=0,IsApOnPosSide=0,CdQuadrant=1,FidPlaneZ_mm=0,SecPlaneZ_mm=0,OrigType=1,cdUv_x=0,cdUv_y=1,';

% Row 3 - mean values for equations
C{3,1}  = 'xMean_pix=';
C{3,3}  = ',yMean_pix=';
C{3,5}  = ',xMean_mm=';
C{3,7}  = ',yMean_mm=';
C{3,9}  = ',zMean_mm=';
C{3,11} = ',';
for i = 1:5; C{3,2*i} = num2str(V3VCalibCam.means(i),6); end

% Row 4 - norm values for equations
C{4,1}  = 'xNorm_pix=';
C{4,3}  = ',yNorm_pix=';
C{4,5}  = ',xNorm_mm=';
C{4,7}  = ',yNorm_mm=';
C{4,9}  = ',zNorm_mm=';
C{4,11} = ',';
for i = 1:5; C{4,2*i}  = num2str(V3VCalibCam.norms(i),6); end

% Row 5 - Z_mm
C{5,1} = 'Z_mm=';
for i=1:nImg
    C{5,2*i} = num2str(V3VCalibCam.Z_mm(i),6);
    C{5,2*i+1} = ',';
end


% Row 6 - grid spacing
C{6,1} = 'GridSpacing_pix=';
for i=1:nImg
    C{6,2*i} = num2str(V3VCalibCam.GridSpc_px(i),6);
    C{6,2*i+1} = ',';
end

% Row 7 - x origin
C{7,1} = 'xOrigin_pix=';
for i=1:nImg
    C{7,2*i} = num2str(V3VCalibCam.XOr_px(i),6);
    C{7,2*i+1} = ',';
end

% Row 8 - y origin
C{8,1} = 'yOrigin_pix=';
for i=1:nImg
    C{8,2*i} = num2str(V3VCalibCam.YOr_px(i),6);
    C{8,2*i+1} = ',';
end

% Row 9 - mean c2w error (mm)
C{9,1} = 'meanC2Werror_mm=';
for i=1:nImg
    C{9,2*i} = num2str(V3VCalibCam.meanc2w_mm(i),6);
    C{9,2*i+1} = ',';
end

% Row 10 - std c2w error (mm)
C{10,1} = 'stdC2Werror_mm=';
for i=1:nImg
    C{10,2*i} = num2str(V3VCalibCam.stdc2w_mm(i),6);
    C{10,2*i+1} = ',';
end

% Row 11 - mean w2c error (pix)
C{11,1} = 'meanW2Cerror_pix=';
for i=1:nImg
    C{11,2*i} = num2str(V3VCalibCam.meanw2c_px(i),6);
    C{11,2*i+1} = ',';
end

% Row 12 - std w2c error (pix)
C{12,1} = 'stdW2Cerror_pix=';
for i=1:nImg
    C{12,2*i} = num2str(V3VCalibCam.stdw2c_px(i),6);
    C{12,2*i+1} = ',';
end

% Row 13 - # valid grid points
C{13,1} = 'numValidGridPoints=';
for i=1:nImg
    C{13,2*i} = num2str(V3VCalibCam.nValGrd(i),6);
    C{13,2*i+1} = ',';
end

% Row 14 - c2w orders and # terms
C{14,1} = 'c2wXorder=';
C{14,3} = ',c2wYorder=';
C{14,5} = ',c2wZorder=';
C{14,7} = ',c2wNumTerms=';
C{14,9} = ',';
for i = 1:4; C{14,2*i} = num2str(V3VCalibCam.c2w_ord(i)); end

% Rows 15 + (nterms-1) - c2w regression coefficients
nterms = V3VCalibCam.c2w_ord(4);
for i = 1:nterms
    for j = 1:5
        C{15+(i-1),2*j-1} = num2str(V3VCalibCam.c2w_reg(i,j),6);
        C{15+(i-1),2*j} = ',';
    end
end

% Rows ... (end of c2w + 2) - w2c orders and # terms
n_w2c = 15 + (nterms-1) + 2;
C{n_w2c,1} = 'w2cXorder=';
C{n_w2c,3} = ',w2cYorder=';
C{n_w2c,5} = ',w2cZorder=';
C{n_w2c,7} = ',w2cNumTerms=';
C{n_w2c,9} = ',';
for i = 1:4; C{n_w2c,2*i} = num2str(V3VCalibCam.w2c_ord(i)); end

% Rows ... (end of c2w + 2) - w2c regression coefficients
for i = 1:nterms
    for j = 1:5
        C{n_w2c+i,2*j-1} = num2str(V3VCalibCam.w2c_reg(i,j),6);
        C{n_w2c+i,2*j} = ',';
    end
end


%% combine horizontal dimension into single and export

[rows,cols] = size(C);

CellOut = cell(rows,1);
for row = 1:rows
    str = '';
    for col = 1:cols
        str = [str C{row,col}];
    end
    CellOut{row,1} = str;
end

end
