



function V3Vgrid = GridTrimMed(V3Vgrid)

% --------------------- HARD CODED VALUE  -------------------------
thresh = 0.4;   % fraction of dots (relative to median) that can be dropped
                % before entirely removing a row of data points
    % You can change this to more or less stringent
    %  - smaller values will remove more points at edges of grid
    %  - larger values will remove less points at edges of grid
% -----------------------------------------------------------------

nImg = numel(V3Vgrid.camL);
                
for Img = 1:nImg
    for Cam = 1:4
        if      Cam == 1 % L
            valid = ~isnan(V3Vgrid.camL(Img).p2dIdx);
        elseif  Cam == 2 % R
            valid = ~isnan(V3Vgrid.camR(Img).p2dIdx);
        elseif  Cam == 3 % T
            valid = ~isnan(V3Vgrid.camT(Img).p2dIdx);
        elseif  Cam == 4 % B
            valid = ~isnan(V3Vgrid.camB(Img).p2dIdx);
        end

        % points around fid mark assumed good
            valid(19,19) = true; valid(21,21) = true; valid(21,19) = true; 

        % count valid points in rows/columns
        ninrows = sum(valid,2);
        nincols = sum(valid,1);

        % normalize by median of all with at least 1 valid point
        ninrowsnorm = ninrows/median(ninrows(ninrows > 0));
        nincolsnorm = nincols/median(nincols(nincols > 0));

        % decide which to remove based on threshold value
        remrows = ninrowsnorm < (1 - thresh); 
        remcols = nincolsnorm < (1 - thresh);
        
        % create validnew to know which are kept after this trimming
        validnew = valid;
        validnew(:,remcols) = false;
        validnew(remrows,:) = false;
        
        % assign NaN to all that should be invalid
        if      Cam == 1 % L
            V3Vgrid.camL(Img).p2dIdx(~validnew) = NaN;
        elseif  Cam == 2 % R
            V3Vgrid.camR(Img).p2dIdx(~validnew) = NaN;
        elseif  Cam == 3 % T
            V3Vgrid.camT(Img).p2dIdx(~validnew) = NaN;
        elseif  Cam == 4 % B
            V3Vgrid.camB(Img).p2dIdx(~validnew) = NaN;
        end
    end
end

end