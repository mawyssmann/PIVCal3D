

% xgrlims = [-75 65]; 
% ygrlims = [-90 10];

function V3Vgrid = GridTrimManual(V3Vgrid,xgrlims,ygrlims)

if isempty(xgrlims); xgrlims = [-95 95]; end
if isempty(ygrlims); ygrlims = [-95 95]; end

coordvec = ((1:39) - 20)*5;
Xwframe = repmat(coordvec,39,1);    
Ywframe = repmat(coordvec,39,1)';

remove = false(39,39);

remove(Xwframe < xgrlims(1)) = true;
remove(Xwframe > xgrlims(2)) = true; 
remove(Ywframe < ygrlims(1)) = true; 
remove(Ywframe > ygrlims(2)) = true; 

nImg = numel(V3Vgrid.camL);

for Img = 1:nImg
    V3Vgrid.camL(Img).p2dIdx(remove) = NaN;
    V3Vgrid.camR(Img).p2dIdx(remove) = NaN;
    V3Vgrid.camT(Img).p2dIdx(remove) = NaN;
    V3Vgrid.camB(Img).p2dIdx(remove) = NaN;
end

end