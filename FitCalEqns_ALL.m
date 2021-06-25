

function CalEqns = FitCalEqns_ALL(V3Vgrid)

% notes for me about indexing
%   - initialize with # rows = grid size (39*39) and # cols = # images
%   - this will help with pulling data together, then I can reshape to
%   single column afterward

%% get vectors with world coordinates (pretty simple)

nImg = numel(V3Vgrid.camL);
zvec = zeros(1,nImg);
for Img = 1:nImg
    zvec(1,Img) = V3Vgrid.camL(Img).z_mm;
end
Zwmat = repmat(zvec,39*39,1);

coordvec = ((1:39) - 20)*5;
Xwframe = repmat(coordvec,39,1);     Xwmat = repmat(Xwframe(:),1,nImg);
Ywframe = repmat(coordvec,39,1)';    Ywmat = repmat(Ywframe(:),1,nImg); 

%% Pull data from Left camera and run regression

p2dIdxLmat  = zeros(39*39,nImg); 
XcLmat      = zeros(39*39,nImg); 
YcLmat      = zeros(39*39,nImg); 

for Img = 1:nImg
    p2dIdxLmat(:,Img)   = V3Vgrid.camL(Img).p2dIdx(:);
    XcLmat(:,Img)       = V3Vgrid.camL(Img).Xc(:);
    YcLmat(:,Img)       = V3Vgrid.camL(Img).Yc(:);
end

XcL = XcLmat(~isnan(p2dIdxLmat));
YcL = YcLmat(~isnan(p2dIdxLmat));
XwL = Xwmat(~isnan(p2dIdxLmat));
YwL = Ywmat(~isnan(p2dIdxLmat));
ZwL = Zwmat(~isnan(p2dIdxLmat));

CalEqnL = FitCalEqn(XcL,YcL,XwL,YwL,ZwL);
disp('Finished Left camera regression');

%% Pull data from Right camera and run regression

p2dIdxRmat  = zeros(39*39,nImg); 
XcRmat      = zeros(39*39,nImg); 
YcRmat      = zeros(39*39,nImg); 

for Img = 1:nImg
    p2dIdxRmat(:,Img)      = V3Vgrid.camR(Img).p2dIdx(:);
    XcRmat(:,Img)       = V3Vgrid.camR(Img).Xc(:);
    YcRmat(:,Img)       = V3Vgrid.camR(Img).Yc(:);
end

XcR = XcRmat(~isnan(p2dIdxRmat));
YcR = YcRmat(~isnan(p2dIdxRmat));
XwR = Xwmat(~isnan(p2dIdxRmat)); 
YwR = Ywmat(~isnan(p2dIdxRmat));
ZwR = Zwmat(~isnan(p2dIdxRmat));

CalEqnR = FitCalEqn(XcR,YcR,XwR,YwR,ZwR);
disp('Finished Right camera regression');

%% Pull data from Top camera and run regression

p2dIdxTmat  = zeros(39*39,nImg); 
XcTmat      = zeros(39*39,nImg); 
YcTmat      = zeros(39*39,nImg); 

for Img = 1:nImg
    p2dIdxTmat(:,Img)   = V3Vgrid.camT(Img).p2dIdx(:);
    XcTmat(:,Img)       = V3Vgrid.camT(Img).Xc(:);
    YcTmat(:,Img)       = V3Vgrid.camT(Img).Yc(:);
end

XcT = XcTmat(~isnan(p2dIdxTmat));
YcT = YcTmat(~isnan(p2dIdxTmat));
XwT = Xwmat(~isnan(p2dIdxTmat)); 
YwT = Ywmat(~isnan(p2dIdxTmat));
ZwT = Zwmat(~isnan(p2dIdxTmat));

CalEqnT = FitCalEqn(XcT,YcT,XwT,YwT,ZwT);
disp('Finished Top camera regression');

%% Pull data from Bottom camera and run regression

p2dIdxBmat  = zeros(39*39,nImg); 
XcBmat      = zeros(39*39,nImg); 
YcBmat      = zeros(39*39,nImg); 

for Img = 1:nImg
    p2dIdxBmat(:,Img)   = V3Vgrid.camB(Img).p2dIdx(:);
    XcBmat(:,Img)       = V3Vgrid.camB(Img).Xc(:);
    YcBmat(:,Img)       = V3Vgrid.camB(Img).Yc(:);
end

XcB = XcBmat(~isnan(p2dIdxBmat));
YcB = YcBmat(~isnan(p2dIdxBmat));
XwB = Xwmat(~isnan(p2dIdxBmat)); 
YwB = Ywmat(~isnan(p2dIdxBmat));
ZwB = Zwmat(~isnan(p2dIdxBmat));

CalEqnB = FitCalEqn(XcB,YcB,XwB,YwB,ZwB);
disp('Finished Bottom camera regression');

%% Save all calibration equations into one structure

CalEqns = struct; 
CalEqns.camL = CalEqnL; 
CalEqns.camR = CalEqnR;
CalEqns.camT = CalEqnT;
CalEqns.camB = CalEqnB;

% CalEqnB = FitCalEqn(XcB,YcB,XwB,YwB,ZwB);

end