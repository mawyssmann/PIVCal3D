

function CalEqn = FitCalEqn(Xc,Yc,Xw,Yw,Zw)

% 4th on x, 4th on Y, and 3rd on Z 
% Note: This outlines the terms and can be changed if needed
pows = [0,0,0; 1,0,0; 0,1,0; 0,0,1; 2,0,0; 1,1,0; 0,2,0; 1,0,1; 0,1,1; ...
	0,0,2; 3,0,0; 2,1,0; 1,2,0; 0,3,0; 2,0,1; 1,1,1; 0,2,1; 1,0,2; ...
	0,1,2; 0,0,3; 4,0,0; 3,1,0; 2,2,0; 1,3,0; 0,4,0; 3,0,1; 2,1,1; ...
	1,2,1; 0,3,1; 2,0,2; 1,1,2; 0,2,2; 1,0,3; 0,1,3];

% calculate normalization variables
means = [mean(Xc)      mean(Yc)      mean(Xw)      mean(Yw)      mean(unique(Zw))]; 
norms = [max(abs(Xc))  max(abs(Yc))  max(abs(Xw))  max(abs(Yw))  max(abs(Zw))];
 % means/norms = [Xc Yc Xw Yw Zw];
 
% normalize variables
Xctil = (Xc - means(1))/norms(1);
Yctil = (Yc - means(2))/norms(2);
Xwtil = (Xw - means(3))/norms(3);
Ywtil = (Yw - means(4))/norms(4);
Zwtil = (Zw - means(5))/norms(5);

% initialize, then loop through 
[npow,~] = size(pows);
X_w2c = zeros(length(Xc),npow); X_c2w = zeros(length(Xc),npow);
for i = 1:npow % compile matrices for regression
    pow_row = pows(i,:);
    X_w2c(:,i) = (Xwtil.^pow_row(1)).* (Ywtil.^pow_row(2)).* (Zwtil.^pow_row(3));
    X_c2w(:,i) = (Xctil.^pow_row(1)).* (Yctil.^pow_row(2)).* (Zwtil.^pow_row(3));
end

%OLD simple regression. Robust below is better!
% bXc_w2c = regress(Xctil,X_w2c); 
% bYc_w2c = regress(Yctil,X_w2c);
% bXw_c2w = regress(Xwtil,X_c2w);
% bYw_c2w = regress(Ywtil,X_c2w);

bXc_w2c = robustfit(X_w2c(:,2:end),Xctil);
bYc_w2c = robustfit(X_w2c(:,2:end),Yctil);
bXw_c2w = robustfit(X_c2w(:,2:end),Xwtil);
bYw_c2w = robustfit(X_c2w(:,2:end),Ywtil);

% assign into output structure file
CalEqn = struct; 

% Info about the calibration equation
CalEqn.Info.c2wXorder = 4; 
CalEqn.Info.c2wYorder = 4; 
CalEqn.Info.c2wZorder = 3;
CalEqn.Info.c2wNumTerms = npow;

CalEqn.Info.w2cXorder = 4; 
CalEqn.Info.w2cYorder = 4; 
CalEqn.Info.w2cZorder = 3;
CalEqn.Info.w2cNumTerms = npow;
CalEqn.Info.pows = pows; 

% regression info
CalEqn.means    = means;
CalEqn.norms    = norms;
CalEqn.bXc_w2c  = bXc_w2c; 
CalEqn.bYc_w2c  = bYc_w2c;
CalEqn.bXw_c2w  = bXw_c2w;
CalEqn.bYw_c2w  = bYw_c2w;

end