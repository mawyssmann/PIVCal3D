
function [] = CalEvalPlot(CalEval,plotver,Img)

if plotver == 1
    Zw = CalEval.camL.Zwvec; 
    mn1a = CalEval.camL.w2cerr_mean;
    st1a = CalEval.camL.w2cerr_std;
    mn2a = CalEval.camR.w2cerr_mean;
    st2a = CalEval.camR.w2cerr_std;
    mn3a = CalEval.camT.w2cerr_mean;
    st3a = CalEval.camT.w2cerr_std;
    mn4a = CalEval.camB.w2cerr_mean;
    st4a = CalEval.camB.w2cerr_std;

    mn1b = CalEval.camL.c2werr_mean;
    st1b = CalEval.camL.c2werr_std;
    mn2b = CalEval.camR.c2werr_mean;
    st2b = CalEval.camR.c2werr_std;
    mn3b = CalEval.camT.c2werr_mean;
    st3b = CalEval.camT.c2werr_std;
    mn4b = CalEval.camB.c2werr_mean;
    st4b = CalEval.camB.c2werr_std;

    figure('Position',[100 100 700 600]); 
    subplot(2,1,1)
    errorbar(Zw,mn1a,st1a,'-og'); hold on; 
    errorbar(Zw,mn2a,st2a,'-or'); errorbar(Zw,mn3a,st3a,'-ob');
    errorbar(Zw,mn4a,st4a,'-om'); legend('Left','Right','Top','Bottom');
    ylim([0 5]); ylabel('W2C error (pix)'); grid on; grid minor; 

    subplot(2,1,2)
    errorbar(Zw,mn1b,st1b,'-og'); hold on; 
    errorbar(Zw,mn2b,st2b,'-or'); errorbar(Zw,mn3b,st3b,'-ob');
    errorbar(Zw,mn4b,st4b,'-om'); ylim([0 0.2]); 
    ylabel('C2W error (mm)'); xlabel('z (mm)'); grid on; grid minor;  

elseif plotver == 2
    
    Xc1      = CalEval.camL.Pts(Img).Xc; 
    Yc1      = CalEval.camL.Pts(Img).Yc; 
    Xcproj1  = CalEval.camL.Pts(Img).Xcproj; 
    Ycproj1  = CalEval.camL.Pts(Img).Ycproj; 
    Xw1      = CalEval.camL.Pts(Img).Xw; 
    Yw1      = CalEval.camL.Pts(Img).Yw;
    Xwproj1  = CalEval.camL.Pts(Img).Xwproj;
    Ywproj1  = CalEval.camL.Pts(Img).Ywproj;
    
    Xc2      = CalEval.camR.Pts(Img).Xc; 
    Yc2      = CalEval.camR.Pts(Img).Yc; 
    Xcproj2  = CalEval.camR.Pts(Img).Xcproj; 
    Ycproj2  = CalEval.camR.Pts(Img).Ycproj; 
    Xw2      = CalEval.camR.Pts(Img).Xw; 
    Yw2      = CalEval.camR.Pts(Img).Yw;
    Xwproj2  = CalEval.camR.Pts(Img).Xwproj;
    Ywproj2  = CalEval.camR.Pts(Img).Ywproj;
    
    Xc3      = CalEval.camT.Pts(Img).Xc; 
    Yc3      = CalEval.camT.Pts(Img).Yc; 
    Xcproj3  = CalEval.camT.Pts(Img).Xcproj; 
    Ycproj3  = CalEval.camT.Pts(Img).Ycproj; 
    Xw3      = CalEval.camT.Pts(Img).Xw; 
    Yw3      = CalEval.camT.Pts(Img).Yw;
    Xwproj3  = CalEval.camT.Pts(Img).Xwproj;
    Ywproj3  = CalEval.camT.Pts(Img).Ywproj;
    
    Xc4      = CalEval.camB.Pts(Img).Xc; 
    Yc4      = CalEval.camB.Pts(Img).Yc; 
    Xcproj4  = CalEval.camB.Pts(Img).Xcproj; 
    Ycproj4  = CalEval.camB.Pts(Img).Ycproj; 
    Xw4      = CalEval.camB.Pts(Img).Xw; 
    Yw4      = CalEval.camB.Pts(Img).Yw;
    Xwproj4  = CalEval.camB.Pts(Img).Xwproj;
    Ywproj4  = CalEval.camB.Pts(Img).Ywproj;
    

    figure('Position',[50 50 1050 750]) % W2C (camera coordinate) plot
    
    subplot(2,2,1);
    plot(Xc1,Yc1,'.',Xcproj1,Ycproj1,'.'); daspect([1 1 1]);
    set(gca,'Ydir','reverse'); xlim([0 4096]); ylim([0 3072]);
    xlabel('X (px)'); ylabel('Y (px)'); legend('Real points','Projection');
    title('W2C projection - Left');
    
    subplot(2,2,3);
    plot(Xc2,Yc2,'.',Xcproj2,Ycproj2,'.'); daspect([1 1 1]);
    set(gca,'Ydir','reverse'); xlim([0 4096]); ylim([0 3072]);
    xlabel('X (px)'); ylabel('Y (px)'); legend('Real points','Projection');
    title('Right');
    
    subplot(2,2,2);
    plot(Xc3,Yc3,'.',Xcproj3,Ycproj3,'.'); daspect([1 1 1]);
    set(gca,'Ydir','reverse'); xlim([0 4096]); ylim([0 3072]);
    xlabel('X (px)'); ylabel('Y (px)'); legend('Real points','Projection');
    title('Top');
    
    subplot(2,2,4);
    plot(Xc4,Yc4,'.',Xcproj4,Ycproj4,'.'); daspect([1 1 1]);
    set(gca,'Ydir','reverse'); xlim([0 4096]); ylim([0 3072]);
    xlabel('X (px)'); ylabel('Y (px)'); legend('Real points','Projection');
    title('Bottom');
    
    
    figure('Position',[50 50 1050 750]) % C2W (world coordinate) plot)
    
    subplot(2,2,1);
    plot(Xw1,Yw1,'.',Xwproj1,Ywproj1,'.'); daspect([1 1 1]);
    xlim([-100 100]); ylim([-100 100]);
    xlabel('X (mm)'); ylabel('Y (mm)'); legend('Real points','Projection');
    title('C2W projection - Left');
    
    subplot(2,2,3);
    plot(Xw2,Yw2,'.',Xwproj2,Ywproj2,'.'); daspect([1 1 1]);
    xlim([-100 100]); ylim([-100 100]);
    xlabel('X (mm)'); ylabel('Y (mm)'); legend('Real points','Projection');
    title('Right');
    
    subplot(2,2,2);
    plot(Xw3,Yw3,'.',Xwproj3,Ywproj3,'.'); daspect([1 1 1]);
    xlim([-100 100]); ylim([-100 100]);
    xlabel('X (mm)'); ylabel('Y (mm)'); legend('Real points','Projection');
    title('Top');
    
    subplot(2,2,4);
    plot(Xw4,Yw4,'.',Xwproj4,Ywproj4,'.'); daspect([1 1 1]);
    xlim([-100 100]); ylim([-100 100]);
    xlabel('X (mm)'); ylabel('Y (mm)'); legend('Real points','Projection');
    title('Bottom');    
end

end % end function