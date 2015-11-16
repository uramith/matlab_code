
clf;
% imgframe = read(videoread,10);
imgframe=imread('sept2img_1.png');
[x1, y1, BW, xi,yi]=roipoly(imgframe);
cntrd=regionprops(BW,'Centroid');
centrd=round(cntrd.Centroid);
xo=centrd(1,1);
yo=centrd(1,2);
% bbox=regionprops(BW,'BoundingBox')
% boxp=round(bbox.BoundingBox)
% frac=(boxp(1,3)-boxp(1,1))/(boxp(1,4)-boxp(1,2));
% istep=(boxp(1,4)-boxp(1,2))/flenth;
% %% outwards from centroid
% xp=0;yp=0;xm=0;ym=0;
% for i=1:5
% yp=abs(yo+(flenth*i));
% ym=abs(yo-(flenth*i));
% xp=(xo+(flenth*i*frac));
% xm=abs(xo-(flenth*i*frac));
% vrtx=[xm ym;xm yp;xp yp;xp ym;xm ym];
% vrtxs{1,i}=floor(vrtx);
% end

%% Inword from bounding box
clear vrtxs; 
flenth=10;
[xid yid]=find(BW > 0);
isteps=round((max(xid)-min(xid))/(flenth*2));
for i=1:isteps
    if i == 1
    xl=min(yid);%+(flenth*i);% x axes from left to centroid
    xr=max(yid);%-(flenth*i);% x axes from right to centroid
    yt=min(xid);%+(flenth*i);% y axes from top to centroid
    yb=max(xid);%-(flenth*i);% y axes from bottom to centroid
    
    else
    xl=min(yid)+(flenth*(i-1));% x axes from left to centroid
    xr=max(yid)-(flenth*(i-1));% x axes from right to centroid
    yt=min(xid)+(flenth*(i-1));% y axes from top to centroid
    yb=max(xid)-(flenth*(i-1));% y axes from bottom to centroid
    end
    vrtx=[xl yb;xl yt;xr yt;xr yb;xl yb];
    vrtxs{1,i}=floor(vrtx);

end

%%
clear lent;
for k=1:length(sept2)
    clear X Y;
    X=sept2{1,k}.X;
    Y=sept2{1,k}.Y;
    clear x y;
    xydata;
    for j=1:length(vrtxs)-1
        v=vrtxs{1,1};
        [posx,posy]=points_in_rect(x,y,v);
        v1=vrtxs{1,j};
        [posx1,posy1]=points_in_rect(x,y,v1);
        v2=vrtxs{1,j+1};
        [posx2,posy2]=points_in_rect(x,y,v2);
        l=length(x);
        lent(j,k)=((length(posx)-length(posx2))/l);
        blent(j,k)=(length(posx1)-length(posx2))/l;
    end
% plot(lent,'.');hold on;
end
figure, plot(lent,'.');
title('Histogram (boundaries towards centre)');
ylabel('Nbr of hits');
xlabel('Different boundary');
figure, plot(blent,'.');
title('Histogram (Bands)');
ylabel('Nbr of hits by total nbr of hits');
xlabel('Different Bands');
