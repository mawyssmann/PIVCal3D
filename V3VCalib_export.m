

% clearvars -except V3VCalib
% savename = 'Cal3';

function V3VCalib_Cell = V3VCalib_export(V3VCalib,savename)

if nargin == 1 % non-export version
    savename = [];
end

CellOutR = MakeCamCell(V3VCalib.camR,0);
CellOutL = MakeCamCell(V3VCalib.camL,1);
CellOutT = MakeCamCell(V3VCalib.camT,2);
CellOutB = MakeCamCell(V3VCalib.camB,3);

V3VCalib_Cell = vertcat(CellOutR,cell(1,1),...
                  CellOutL,cell(1,1),...
                  CellOutT,cell(1,1),...
                  CellOutB,cell(1,1));

if ~isempty(savename)
    writecell(V3VCalib_Cell, [savename '_Matlab.txt'] , 'QuoteStrings', false);
    movefile([savename '_Matlab.txt'],[savename '_Matlab.V3VCalib']);
%     movefile('Calib_Matlab.txt','Calib_Matlab.V3VCalib');
end

end