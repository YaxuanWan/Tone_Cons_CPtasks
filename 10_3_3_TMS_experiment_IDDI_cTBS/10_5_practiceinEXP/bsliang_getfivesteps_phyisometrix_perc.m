%**************************************************************************
% 本程序可完成利用Psychometric function计算域值的数据批处理,并可绘制Psychometric function拟和曲线
%**************************************************************************
% 版权属于北京大学听觉与视觉国家重点实验室
%**************************************************************************
function [xmid,ys]=bsliang_getfivesteps_phyisometrix_perc(x,y)
%options = optimset('LargeScale','off','LevenbergMarquardt','on');

a0=[0.1,-8];
[a,~,~,~,~] = lsqcurvefit(@myfun,a0,x,y);

%**************************************************************************
%绘制数据的拟和曲线
%**************************************************************************

ys=100./(1+exp(-a(1)*(x-a(2))));
bsliang = @(x0)(100./(1+exp(-a(1)*(x0-a(2))))-50);
options = optimset('TolX',0.00000000000000000001);
xmid=fzero(bsliang,(x(1)+x(end))/2,options);
