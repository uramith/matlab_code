% for q=4:56
X=sept2{1,q}.X;
Y=sept2{1,q}.Y;
xydata
%%
n=hist3([y x],[50 50]);
n1 = n';
n1(size(n,1) + 1, size(n,2) + 1) = 0;
xb = linspace(min(x),max(x),size(n,1)+1);
yb = linspace(min(y),max(y),size(n,1)+1);
h=pcolor(yb,xb,n1);
set(h,'EdgeColor','none');
colormap(hot)
caxis([0 500]);
title(files(q).name)
% pause
% end