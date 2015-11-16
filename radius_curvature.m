for i=1:5000
    for j=1:550-3%length(Q_loc_estimateX(:,i))-3
x1=Q_loc_estimateX(j,i);
x2=Q_loc_estimateX(j+1,i);
x3=Q_loc_estimateX(j+3,i);
y1=Q_loc_estimateY(j,i);
y2=Q_loc_estimateY(j+1,i);
y3=Q_loc_estimateY(j+3,i);
slope1=(y2-y1)/(x2-x1);
slope2=(y3-y2)/(x3-x2);

%--------------------------------------------------------------------------
% slope approximation methode
%--------------------------------------------------------------------------
avg_slope=(slope1+slope2)/2;
midx1=(x2+x1)/2;
midx2=(x3+x2)/2;
md_dif=abs(midx1-midx2);
slope_slope=(slope1-slope2)/md_dif;
curve=((1+avg_slope^2)^(3/2))/(slope_slope)^2;
velx=(x2-x1)/0.03;
vely=(y2-y1)/0.03;
vel=sqrt(velx^2+vely^2);
radius1=(vel^2)/curve;

%--------------------------------------------------
% 3 points methode
%--------------------------------------------------
xc(i,j)=[[(slope1*slope2)*(y1-y3)]+...
    [slope2*(x1+x2)]-...
    [slope1*(x2+x3)]]/(2*(slope2-slope1));
yc(i,j)=((-1/slope1)*(xc(i,j)-midx1))+(y1+y2)/2;
radius2=sqrt((xc(i,j)-x1)^2+(yc(i,j)-y1)^2);
%  centers(i,d)=(xc(i,j));
%  centers(i,d+1)=yc(i,j);

    end
end