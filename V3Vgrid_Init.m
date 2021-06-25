
function V3Vgrid = V3Vgrid_Init(filenames,pathname)

V3Vgrid = struct;
V3Vgrid.datapath = pathname;
nImg = length(filenames)/4; % # image sets (4 cameras per image set)

% automatically find z by reading image info
zplanes = zeros(1,nImg); 
fileidx = 2:4:length(filenames); % file locations for cam L (z is same for all cameras)
for i = 1:nImg
    filenamez = filenames{1,fileidx(i)};        % p2d filename
    filenamez = [filenamez(1:end-4) '.TIF'];    % tif filename
    info = imfinfo([pathname filenamez]);       % image info structure
    zpl = str2double(info.UnknownTags(6).Value);% z location stored by Insight
    zplanes(i) = zpl;                           % convert & store
end

% loop for camera L
fileidx = 2:4:length(filenames); % file locations for cam L
for i = 1:nImg
    pathname_l = V3Vgrid.datapath; 
    filename_l = filenames{1,fileidx(i)};
    V3Vgrid.camL(i).filename    = filename_l;
    V3Vgrid.camL(i).z_mm        = zplanes(i);
    
    % load it then save it here
    p2d = importp2d([pathname_l filename_l]);
    V3Vgrid.camL(i).Xp2d        = p2d(:,1);
    V3Vgrid.camL(i).Yp2d        = p2d(:,2);
    V3Vgrid.camL(i).np2d        = length(p2d);
    
    % just initializing these for now. Used later when grid is identified.
    V3Vgrid.camL(i).ctrlIdx     = [];
    V3Vgrid.camL(i).p2dIdx      = [];
    V3Vgrid.camL(i).Xc          = [];
    V3Vgrid.camL(i).Yc          = [];
    V3Vgrid.camL(i).nc          = [];
end

% loop for camera R
fileidx = 3:4:length(filenames); % file locations for cam R
for i = 1:nImg
    pathname_l = V3Vgrid.datapath; 
    filename_l = filenames{1,fileidx(i)};
    V3Vgrid.camR(i).filename    = filename_l;
    V3Vgrid.camR(i).z_mm        = zplanes(i);
    
    % load it then save it here
    p2d = importp2d([pathname_l filename_l]);
    V3Vgrid.camR(i).Xp2d        = p2d(:,1);
    V3Vgrid.camR(i).Yp2d        = p2d(:,2);
    V3Vgrid.camR(i).np2d        = length(p2d);
    
    % just initializing these for now. Used later when grid is identified.
    V3Vgrid.camR(i).ctrlIdx     = [];
    V3Vgrid.camR(i).p2dIdx      = [];
    V3Vgrid.camR(i).Xc          = [];
    V3Vgrid.camR(i).Yc          = [];
    V3Vgrid.camR(i).nc          = [];
end

% loop for camera T
fileidx = 4:4:length(filenames); % file locations for cam B
for i = 1:nImg
    pathname_l = V3Vgrid.datapath; 
    filename_l = filenames{1,fileidx(i)};
    V3Vgrid.camT(i).filename    = filename_l;
    V3Vgrid.camT(i).z_mm        = zplanes(i);
    
    % load it then save it here
    p2d = importp2d([pathname_l filename_l]);
    V3Vgrid.camT(i).Xp2d        = p2d(:,1);
    V3Vgrid.camT(i).Yp2d        = p2d(:,2);
    V3Vgrid.camT(i).np2d        = length(p2d);
    
    % just initializing these for now. Used later when grid is identified.
    V3Vgrid.camT(i).ctrlIdx     = [];
    V3Vgrid.camT(i).p2dIdx      = [];
    V3Vgrid.camT(i).Xc          = [];
    V3Vgrid.camT(i).Yc          = [];
    V3Vgrid.camT(i).nc          = [];
end

% loop for camera B
fileidx = 1:4:length(filenames); % file locations for cam B
for i = 1:nImg
    pathname_l = V3Vgrid.datapath; 
    filename_l = filenames{1,fileidx(i)};
    V3Vgrid.camB(i).filename    = filename_l;
    V3Vgrid.camB(i).z_mm        = zplanes(i);
    
    % load it then save it here
    p2d = importp2d([pathname_l filename_l]);
    V3Vgrid.camB(i).Xp2d        = p2d(:,1);
    V3Vgrid.camB(i).Yp2d        = p2d(:,2);
    V3Vgrid.camB(i).np2d        = length(p2d);
    
    % just initializing these for now. Used later when grid is identified.
    V3Vgrid.camB(i).ctrlIdx     = [];
    V3Vgrid.camB(i).p2dIdx      = [];
    V3Vgrid.camB(i).Xc          = [];
    V3Vgrid.camB(i).Yc          = [];
    V3Vgrid.camB(i).nc          = [];
end

% end