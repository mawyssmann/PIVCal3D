

function [p2dIdx,Xc,Yc] = FindGrid(Xp2d,Yp2d,ctrl_inds)

%% Initialize system with control points

% notes to self: 
% - cal grid has 39 x 39 grid points. Fid mark thus at 20,20
% - note to self... (row,col)   ... for indexing
% - I'm using (1,1) as lower left point and (39,39) as upper right point

% Initialize key matrices
p2dIdx  = NaN(39,39);  % start with none assigned and then assign into here
Xc      = NaN(39,39);   
Yc      = NaN(39,39);

% Assign three known points       note to self... (row,col)
    % fid mark
    p2dIdx(20,20)   = ctrl_inds(1);
    Xc(20,20)       = Xp2d(ctrl_inds(1));
    Yc(20,20)       = Yp2d(ctrl_inds(1));
    % above fid mark
    p2dIdx(21,20)   = ctrl_inds(2);
    Xc(21,20)       = Xp2d(ctrl_inds(2));
    Yc(21,20)       = Yp2d(ctrl_inds(2));
    % right of fid mark
    p2dIdx(20,21)   = ctrl_inds(3);
    Xc(20,21)       = Xp2d(ctrl_inds(3));
    Yc(20,21)       = Yp2d(ctrl_inds(3));
    

%% find row of points with fid mark
    
% projecting to left of control points
col = 19;
row = 20;
tol = 0.07;
while col >= 1
    dxi = Xc(row,col+2) - Xc(row,col+1); 
    dyi = Yc(row,col+2) - Yc(row,col+1);
    
    Xc(row,col) = Xc(row,col+1) - dxi;
    Yc(row,col) = Yc(row,col+1) - dyi;
    
    dist = pdist2([Xc(row,col) Yc(row,col)],[Xp2d Yp2d])/sqrt(dxi^2 + dyi^2);
    [~, minIdx] = min(dist);
    if dist(minIdx) <= tol % determined p2d point is accurate, so assign Idx and replace in Xc and Yc 
        p2dIdx(row,col) = minIdx;
        Xc(row,col)     = Xp2d(minIdx); 
        Yc(row,col)     = Yp2d(minIdx);
    end
    col = col-1;
end

% projecting to right of control points
col = 22;
row = 20;
tol = 0.1;
while col <= 39
    dxi = Xc(row,col-1) - Xc(row,col-2); 
    dyi = Yc(row,col-1) - Yc(row,col-2);
    
    Xc(row,col) = Xc(row,col-1) + dxi;
    Yc(row,col) = Yc(row,col-1) + dyi;
    
    dist = pdist2([Xc(row,col) Yc(row,col)],[Xp2d Yp2d])/sqrt(dxi^2 + dyi^2);
    [~, minIdx] = min(dist);
    if dist(minIdx) <= tol % determined p2d point is accurate, so assign Idx and replace in Xc and Yc 
        p2dIdx(row,col) = minIdx;
        Xc(row,col)     = Xp2d(minIdx); 
        Yc(row,col)     = Yp2d(minIdx);
    end
    col = col+1;
end

% clean the values that werent associated with real data points
dummyIdx = 1:39;
validIdx = ~isnan(p2dIdx(row,:));

Xc(row,:) = interp1(dummyIdx(validIdx),Xc(row,validIdx),dummyIdx,'linear','extrap');
Yc(row,:) = interp1(dummyIdx(validIdx),Yc(row,validIdx),dummyIdx,'linear','extrap');


%% project downward

row = 19; 
while row >= 1
    dxi      = Xc(row+2,20) - Xc(row+1,20);
    dyi      = Yc(row+2,20) - Yc(row+1,20);
    Xc(row,:) = Xc(row+1,:) - dxi;
    Yc(row,:) = Yc(row+1,:) - dyi;

    for col = 1:39
        dist = pdist2([Xc(row,col) Yc(row,col)],[Xp2d Yp2d])/sqrt(dxi^2 + dyi^2);
        [~, minIdx] = min(dist);
        if dist(minIdx) <= tol % determined p2d point is accurate, so assign Idx and replace in Xc and Yc 
            p2dIdx(row,col) = minIdx;
            Xc(row,col)     = Xp2d(minIdx); 
            Yc(row,col)     = Yp2d(minIdx);
        end
    end

    dummyIdx = 1:39;
    validIdx = ~isnan(p2dIdx(row,:));
    if sum(validIdx) >= 2
        Xc(row,:) = interp1(dummyIdx(validIdx),Xc(row,validIdx),dummyIdx,'linear','extrap');
        Yc(row,:) = interp1(dummyIdx(validIdx),Yc(row,validIdx),dummyIdx,'linear','extrap');
    end
    row = row-1;
end

%% project upward

row = 21; 
while row <= 39
    dxi      = Xc(row-1,20) - Xc(row-2,20);
    dyi      = Yc(row-1,20) - Yc(row-2,20);
    Xc(row,:) = Xc(row-1,:) + dxi;
    Yc(row,:) = Yc(row-1,:) + dyi;

    for col = 1:39
        dist = pdist2([Xc(row,col) Yc(row,col)],[Xp2d Yp2d])/sqrt(dxi^2 + dyi^2);
        [~, minIdx] = min(dist);
        if dist(minIdx) <= tol % determined p2d point is accurate, so assign Idx and replace in Xc and Yc 
            p2dIdx(row,col) = minIdx;
            Xc(row,col)     = Xp2d(minIdx); 
            Yc(row,col)     = Yp2d(minIdx);
        end
    end

    dummyIdx = 1:39;
    validIdx = ~isnan(p2dIdx(row,:));
    if sum(validIdx) >= 2
        Xc(row,:) = interp1(dummyIdx(validIdx),Xc(row,validIdx),dummyIdx,'linear','extrap');
        Yc(row,:) = interp1(dummyIdx(validIdx),Yc(row,validIdx),dummyIdx,'linear','extrap');
    end
    row = row+1;
end

end