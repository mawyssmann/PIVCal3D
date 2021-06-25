

function V3Vgrid = FindGrid_ALL(V3Vgrid)


nimg = numel(V3Vgrid.camL);

for img = 1:nimg % camL
    Xp2d        = V3Vgrid.camL(img).Xp2d;
    Yp2d        = V3Vgrid.camL(img).Yp2d;
    ctrl_inds   = V3Vgrid.camL(img).ctrlIdx;
    
    [p2dIdx,Xc,Yc] = FindGrid(Xp2d,Yp2d,ctrl_inds);
    
    V3Vgrid.camL(img).p2dIdx    = p2dIdx;
    V3Vgrid.camL(img).Xc        = Xc;
    V3Vgrid.camL(img).Yc        = Yc; 
    V3Vgrid.camL(img).nc        = sum(sum(~isnan(p2dIdx)));
end

for img = 1:nimg % camR
    Xp2d        = V3Vgrid.camR(img).Xp2d;
    Yp2d        = V3Vgrid.camR(img).Yp2d;
    ctrl_inds   = V3Vgrid.camR(img).ctrlIdx;
    
    [p2dIdx,Xc,Yc] = FindGrid(Xp2d,Yp2d,ctrl_inds);
    
    V3Vgrid.camR(img).p2dIdx    = p2dIdx;
    V3Vgrid.camR(img).Xc        = Xc;
    V3Vgrid.camR(img).Yc        = Yc; 
    V3Vgrid.camR(img).nc        = sum(sum(~isnan(p2dIdx)));
end

for img = 1:nimg % camT
    Xp2d        = V3Vgrid.camT(img).Xp2d;
    Yp2d        = V3Vgrid.camT(img).Yp2d;
    ctrl_inds   = V3Vgrid.camT(img).ctrlIdx;
    
    [p2dIdx,Xc,Yc] = FindGrid(Xp2d,Yp2d,ctrl_inds);
    
    V3Vgrid.camT(img).p2dIdx    = p2dIdx;
    V3Vgrid.camT(img).Xc        = Xc;
    V3Vgrid.camT(img).Yc        = Yc; 
    V3Vgrid.camT(img).nc        = sum(sum(~isnan(p2dIdx)));
end

for img = 1:nimg % camB
    Xp2d        = V3Vgrid.camB(img).Xp2d;
    Yp2d        = V3Vgrid.camB(img).Yp2d;
    ctrl_inds   = V3Vgrid.camB(img).ctrlIdx;
    
    [p2dIdx,Xc,Yc] = FindGrid(Xp2d,Yp2d,ctrl_inds);
    
    V3Vgrid.camB(img).p2dIdx    = p2dIdx;
    V3Vgrid.camB(img).Xc        = Xc;
    V3Vgrid.camB(img).Yc        = Yc; 
    V3Vgrid.camB(img).nc        = sum(sum(~isnan(p2dIdx)));
end

end