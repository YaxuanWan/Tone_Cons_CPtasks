function ORDERnum=bsliang_gainORDERnum(PARnum)
% 原本安排的是48个被试，因此被试实验顺序的平衡也是按着这个来的。
%但是事实上被试可能或多或少，因此真正实验的时候每个被试都有一个自己的被试编号
%（跟第一次实验一样），同时有一个ORDER编号用来确定被试做实验的block顺序。ORDER编号是可以重复的。

% tranMAT=[1:47;2:48]';
 tranMAT=[1,1;...
          2,2;...
          3,3;...
          4,4;...
          5,5;...
          24,24;...
          25,1];
%第一列为被试自己的编号，第二列为被试的ORDER编号。

ORDERnum=tranMAT(tranMAT(:,1)==PARnum,2);