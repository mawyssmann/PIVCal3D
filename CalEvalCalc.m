

function CalEval = CalEvalCalc(V3Vgrid,CalEqns)

%% Initialize a few things and get vectors with world coordinates (pretty simple)

% clearvars -except V3Vgrid CalEqns

nImg = numel(V3Vgrid.camL);

coordvec = ((1:39) - 20)*5;
Xwframe = repmat(coordvec,39,1);     %Xwmat = repmat(Xwframe(:),1,nImg);
Ywframe = repmat(coordvec,39,1)';    %Ywmat = repmat(Ywframe(:),1,nImg);

CalEval = struct;

% Camera projection equation evaluations
for Cam = 1:4 % loop over cameras 1=L; 2=R; 3=T; 4=B;
    if      Cam == 1
        CalEqn = CalEqns.camL; 
    elseif  Cam == 2
        CalEqn = CalEqns.camR; 
    elseif  Cam == 3
        CalEqn = CalEqns.camT; 
    elseif  Cam == 4
        CalEqn = CalEqns.camB; 
    end
    
    pows = CalEqn.Info.pows;
    [npow,~] = size(pows);
    means = CalEqn.means; 
    norms = CalEqn.norms;

    % initialize vectors for errors to store
    c2werr_mean     = zeros(nImg,1); 
    c2werr_std      = zeros(nImg,1);
    w2cerr_mean     = zeros(nImg,1); 
    w2cerr_std      = zeros(nImg,1);
    Zwvec           = zeros(nImg,1);

    for Img = 1:nImg
        if      Cam == 1
            p2dIdx     = V3Vgrid.camL(Img).p2dIdx(:);
            Xc         = V3Vgrid.camL(Img).Xc(~isnan(p2dIdx));
            Yc         = V3Vgrid.camL(Img).Yc(~isnan(p2dIdx));
            Zw         = V3Vgrid.camL(Img).z_mm * ones(size(Xc));
        elseif  Cam == 2
            p2dIdx     = V3Vgrid.camR(Img).p2dIdx(:);
            Xc         = V3Vgrid.camR(Img).Xc(~isnan(p2dIdx));
            Yc         = V3Vgrid.camR(Img).Yc(~isnan(p2dIdx));
            Zw         = V3Vgrid.camR(Img).z_mm * ones(size(Xc));
        elseif  Cam == 3
            p2dIdx     = V3Vgrid.camT(Img).p2dIdx(:);
            Xc         = V3Vgrid.camT(Img).Xc(~isnan(p2dIdx));
            Yc         = V3Vgrid.camT(Img).Yc(~isnan(p2dIdx));
            Zw         = V3Vgrid.camT(Img).z_mm * ones(size(Xc));
        elseif  Cam == 4
            p2dIdx     = V3Vgrid.camB(Img).p2dIdx(:);
            Xc         = V3Vgrid.camB(Img).Xc(~isnan(p2dIdx));
            Yc         = V3Vgrid.camB(Img).Yc(~isnan(p2dIdx));
            Zw         = V3Vgrid.camB(Img).z_mm * ones(size(Xc));
        end
        
        Xw         = Xwframe(~isnan(p2dIdx));
        Yw         = Ywframe(~isnan(p2dIdx));
        Zwvec(Img,1) = V3Vgrid.camL(Img).z_mm;

        % normalize variables
        Xctil      = (Xc - means(1))/norms(1);
        Yctil      = (Yc - means(2))/norms(2);
        Xwtil      = (Xw - means(3))/norms(3);
        Ywtil      = (Yw - means(4))/norms(4);
        Zwtil      = (Zw - means(5))/norms(5);

        % initialize storage
        nXc = length(Xctil); 
        X_w2c = zeros(nXc,npow); X_c2w = zeros(nXc,npow);
        for i = 1:npow % compile matrices for regression
            pow_row = pows(i,:);
            X_w2c(:,i) = (Xwtil.^pow_row(1)).* (Ywtil.^pow_row(2)).* (Zwtil.^pow_row(3));
            X_c2w(:,i) = (Xctil.^pow_row(1)).* (Yctil.^pow_row(2)).* (Zwtil.^pow_row(3));
        end

        % pull equation coefficients
        bmatXc_w2c = repmat(CalEqn.bXc_w2c',nXc,1);
        bmatYc_w2c = repmat(CalEqn.bYc_w2c',nXc,1);
        bmatXw_c2w = repmat(CalEqn.bXw_c2w',nXc,1);
        bmatYw_c2w = repmat(CalEqn.bYw_c2w',nXc,1);

        % project using equations
        Xctilproj = sum(bmatXc_w2c.*X_w2c,2);
        Yctilproj = sum(bmatYc_w2c.*X_w2c,2);
        Xwtilproj = sum(bmatXw_c2w.*X_c2w,2);
        Ywtilproj = sum(bmatYw_c2w.*X_c2w,2);

        % unnormalize
        Xcproj = Xctilproj*norms(1) + means(1); 
        Ycproj = Yctilproj*norms(2) + means(2);
        Xwproj = Xwtilproj*norms(3) + means(3); 
        Ywproj = Ywtilproj*norms(4) + means(4); 

        % error estimation
        XYcreal = [Xc,Yc];    XYcproj = [Xcproj,Ycproj];
            XYcdiff = XYcreal - XYcproj;  XYcerr = sum(XYcdiff.^2,2).^0.5;
        XYwreal = [Xw,Yw];    XYwproj = [Xwproj,Ywproj];
            XYwdiff = XYwreal - XYwproj;  XYwerr = sum(XYwdiff.^2,2).^0.5;

        w2cerr_mean(Img,1)  = mean(XYcerr);
        w2cerr_std(Img,1)   = std(XYcerr); 
        c2werr_mean(Img,1)  = mean(XYwerr);
        c2werr_std(Img,1)   = std(XYwerr); 
        
        % save data in structure file based on camera
        if      Cam == 1
            CalEval.camL.Pts(Img).Xc        = Xc; 
            CalEval.camL.Pts(Img).Yc        = Yc; 
            CalEval.camL.Pts(Img).Xcproj    = Xcproj; 
            CalEval.camL.Pts(Img).Ycproj    = Ycproj; 
            CalEval.camL.Pts(Img).Xw        = Xw; 
            CalEval.camL.Pts(Img).Yw        = Yw; 
            CalEval.camL.Pts(Img).Xwproj    = Xwproj; 
            CalEval.camL.Pts(Img).Ywproj    = Ywproj; 
            if Img == nImg
                CalEval.camL.c2werr_mean    = c2werr_mean;
                CalEval.camL.c2werr_std     = c2werr_std;
                CalEval.camL.w2cerr_mean    = w2cerr_mean;
                CalEval.camL.w2cerr_std     = w2cerr_std;
                CalEval.camL.Zwvec          = Zwvec;
            end
        elseif  Cam == 2
            CalEval.camR.Pts(Img).Xc        = Xc; 
            CalEval.camR.Pts(Img).Yc        = Yc; 
            CalEval.camR.Pts(Img).Xcproj    = Xcproj; 
            CalEval.camR.Pts(Img).Ycproj    = Ycproj; 
            CalEval.camR.Pts(Img).Xw        = Xw; 
            CalEval.camR.Pts(Img).Yw        = Yw; 
            CalEval.camR.Pts(Img).Xwproj    = Xwproj; 
            CalEval.camR.Pts(Img).Ywproj    = Ywproj; 
            if Img == nImg
                CalEval.camR.c2werr_mean    = c2werr_mean;
                CalEval.camR.c2werr_std     = c2werr_std;
                CalEval.camR.w2cerr_mean    = w2cerr_mean;
                CalEval.camR.w2cerr_std     = w2cerr_std;
                CalEval.camR.Zwvec          = Zwvec;
            end
        elseif  Cam == 3
            CalEval.camT.Pts(Img).Xc        = Xc; 
            CalEval.camT.Pts(Img).Yc        = Yc; 
            CalEval.camT.Pts(Img).Xcproj    = Xcproj; 
            CalEval.camT.Pts(Img).Ycproj    = Ycproj; 
            CalEval.camT.Pts(Img).Xw        = Xw; 
            CalEval.camT.Pts(Img).Yw        = Yw; 
            CalEval.camT.Pts(Img).Xwproj    = Xwproj; 
            CalEval.camT.Pts(Img).Ywproj    = Ywproj; 
            if Img == nImg
                CalEval.camT.c2werr_mean    = c2werr_mean;
                CalEval.camT.c2werr_std     = c2werr_std;
                CalEval.camT.w2cerr_mean    = w2cerr_mean;
                CalEval.camT.w2cerr_std     = w2cerr_std;
                CalEval.camT.Zwvec          = Zwvec;
            end
        elseif  Cam == 4
            CalEval.camB.Pts(Img).Xc        = Xc; 
            CalEval.camB.Pts(Img).Yc        = Yc; 
            CalEval.camB.Pts(Img).Xcproj    = Xcproj; 
            CalEval.camB.Pts(Img).Ycproj    = Ycproj; 
            CalEval.camB.Pts(Img).Xw        = Xw; 
            CalEval.camB.Pts(Img).Yw        = Yw; 
            CalEval.camB.Pts(Img).Xwproj    = Xwproj; 
            CalEval.camB.Pts(Img).Ywproj    = Ywproj; 
            if Img == nImg
                CalEval.camB.c2werr_mean    = c2werr_mean;
                CalEval.camB.c2werr_std     = c2werr_std;
                CalEval.camB.w2cerr_mean    = w2cerr_mean;
                CalEval.camB.w2cerr_std     = w2cerr_std;
                CalEval.camB.Zwvec          = Zwvec;
            end
        end % camera if statement
    end % image loop
end % camera loop

% clearvars -except V3Vgrid CalEqns CalEval

end
