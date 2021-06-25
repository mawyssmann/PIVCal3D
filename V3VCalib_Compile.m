
% clearvars -except V3Vgrid CalEqns CalEval


function V3VCalib = V3VCalib_Compile(V3Vgrid,CalEqns,CalEval)

% Initialize
V3VCalib = struct; 
nImg = numel(V3Vgrid.camL); 

%% Left camera

V3VgridCam = V3Vgrid.camL;
CalEqnsCam = CalEqns.camL; 

[Z_mm,GridSpc_px,XOr_px,YOr_px,nValGrd] = PullV3Vgrid(V3VgridCam,nImg);
[means,norms,c2w_ord,c2w_reg,w2c_ord,w2c_reg] = PullCalEqns(CalEqnsCam);

V3VCalib.camL.means             = means;
V3VCalib.camL.norms             = norms;
V3VCalib.camL.Z_mm              = Z_mm;
V3VCalib.camL.GridSpc_px        = GridSpc_px;
V3VCalib.camL.XOr_px            = XOr_px;
V3VCalib.camL.YOr_px            = YOr_px;
V3VCalib.camL.meanc2w_mm        = CalEval.camL.c2werr_mean';
V3VCalib.camL.stdc2w_mm         = CalEval.camL.c2werr_std';
V3VCalib.camL.meanw2c_px        = CalEval.camL.w2cerr_mean';
V3VCalib.camL.stdw2c_px         = CalEval.camL.w2cerr_std';
V3VCalib.camL.nValGrd           = nValGrd;
V3VCalib.camL.c2w_ord           = c2w_ord;
V3VCalib.camL.c2w_reg           = c2w_reg;
V3VCalib.camL.w2c_ord           = w2c_ord;
V3VCalib.camL.w2c_reg           = w2c_reg;

%% Right camera

V3VgridCam = V3Vgrid.camR;
CalEqnsCam = CalEqns.camR; 

[Z_mm,GridSpc_px,XOr_px,YOr_px,nValGrd] = PullV3Vgrid(V3VgridCam,nImg);
[means,norms,c2w_ord,c2w_reg,w2c_ord,w2c_reg] = PullCalEqns(CalEqnsCam);

V3VCalib.camR.means             = means;
V3VCalib.camR.norms             = norms;
V3VCalib.camR.Z_mm              = Z_mm;
V3VCalib.camR.GridSpc_px        = GridSpc_px;
V3VCalib.camR.XOr_px            = XOr_px;
V3VCalib.camR.YOr_px            = YOr_px;
V3VCalib.camR.meanc2w_mm        = CalEval.camR.c2werr_mean';
V3VCalib.camR.stdc2w_mm         = CalEval.camR.c2werr_std';
V3VCalib.camR.meanw2c_px        = CalEval.camR.w2cerr_mean';
V3VCalib.camR.stdw2c_px         = CalEval.camR.w2cerr_std';
V3VCalib.camR.nValGrd           = nValGrd;
V3VCalib.camR.c2w_ord           = c2w_ord;
V3VCalib.camR.c2w_reg           = c2w_reg;
V3VCalib.camR.w2c_ord           = w2c_ord;
V3VCalib.camR.w2c_reg           = w2c_reg;

%% Top camera

V3VgridCam = V3Vgrid.camT;
CalEqnsCam = CalEqns.camT; 

[Z_mm,GridSpc_px,XOr_px,YOr_px,nValGrd] = PullV3Vgrid(V3VgridCam,nImg);
[means,norms,c2w_ord,c2w_reg,w2c_ord,w2c_reg] = PullCalEqns(CalEqnsCam);

V3VCalib.camT.means             = means;
V3VCalib.camT.norms             = norms;
V3VCalib.camT.Z_mm              = Z_mm;
V3VCalib.camT.GridSpc_px        = GridSpc_px;
V3VCalib.camT.XOr_px            = XOr_px;
V3VCalib.camT.YOr_px            = YOr_px;
V3VCalib.camT.meanc2w_mm        = CalEval.camT.c2werr_mean';
V3VCalib.camT.stdc2w_mm         = CalEval.camT.c2werr_std';
V3VCalib.camT.meanw2c_px        = CalEval.camT.w2cerr_mean';
V3VCalib.camT.stdw2c_px         = CalEval.camT.w2cerr_std';
V3VCalib.camT.nValGrd           = nValGrd;
V3VCalib.camT.c2w_ord           = c2w_ord;
V3VCalib.camT.c2w_reg           = c2w_reg;
V3VCalib.camT.w2c_ord           = w2c_ord;
V3VCalib.camT.w2c_reg           = w2c_reg;

%% Bottom camera

V3VgridCam = V3Vgrid.camB;
CalEqnsCam = CalEqns.camB; 

[Z_mm,GridSpc_px,XOr_px,YOr_px,nValGrd] = PullV3Vgrid(V3VgridCam,nImg);
[means,norms,c2w_ord,c2w_reg,w2c_ord,w2c_reg] = PullCalEqns(CalEqnsCam);

V3VCalib.camB.means             = means;
V3VCalib.camB.norms             = norms;
V3VCalib.camB.Z_mm              = Z_mm;
V3VCalib.camB.GridSpc_px        = GridSpc_px;
V3VCalib.camB.XOr_px            = XOr_px;
V3VCalib.camB.YOr_px            = YOr_px;
V3VCalib.camB.meanc2w_mm        = CalEval.camB.c2werr_mean';
V3VCalib.camB.stdc2w_mm         = CalEval.camB.c2werr_std';
V3VCalib.camB.meanw2c_px        = CalEval.camB.w2cerr_mean';
V3VCalib.camB.stdw2c_px         = CalEval.camB.w2cerr_std';
V3VCalib.camB.nValGrd           = nValGrd;
V3VCalib.camB.c2w_ord           = c2w_ord;
V3VCalib.camB.c2w_reg           = c2w_reg;
V3VCalib.camB.w2c_ord           = w2c_ord;
V3VCalib.camB.w2c_reg           = w2c_reg;


end

function [Z_mm,GridSpc_px,XOr_px,YOr_px,nValGrd] = PullV3Vgrid(V3VgridCam,nImg)

% initalize for a loop that pulls info
Z_mm        = zeros(1,nImg);
GridSpc_px  = zeros(1,nImg);
XOr_px      = zeros(1,nImg);
YOr_px      = zeros(1,nImg);
nValGrd     = zeros(1,nImg);

for Img = 1:nImg
    Z_mm      (1,Img) = V3VgridCam(Img).z_mm;
    GridSpc_px(1,Img) = V3VgridCam(Img).GrdSpc;
    XOr_px    (1,Img) = V3VgridCam(Img).XcOr;
    YOr_px    (1,Img) = V3VgridCam(Img).YcOr;
    nValGrd   (1,Img) = V3VgridCam(Img).nc;
end

end

function [means,norms,c2w_ord,c2w_reg,w2c_ord,w2c_reg] = PullCalEqns(CalEqnsCam)

means = CalEqnsCam.means;
norms = CalEqnsCam.norms;

c2w_ord =  [CalEqnsCam.Info.c2wXorder,...
            CalEqnsCam.Info.c2wYorder,...
            CalEqnsCam.Info.c2wZorder,...
            CalEqnsCam.Info.c2wNumTerms];
w2c_ord =  [CalEqnsCam.Info.w2cXorder,...
            CalEqnsCam.Info.w2cYorder,...
            CalEqnsCam.Info.w2cZorder,...
            CalEqnsCam.Info.w2cNumTerms];
        
pows    = CalEqnsCam.Info.pows;
c2w_reg = zeros(length(pows),5);    c2w_reg(:,3:5) = pows; 
w2c_reg = zeros(length(pows),5);    w2c_reg(:,3:5) = pows;

c2w_reg(:,1) = CalEqnsCam.bXw_c2w; 
c2w_reg(:,2) = CalEqnsCam.bYw_c2w; 

w2c_reg(:,1) = CalEqnsCam.bXc_w2c; 
w2c_reg(:,2) = CalEqnsCam.bYc_w2c; 

end