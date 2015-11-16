function [posx,posy]=points_in_rect(x,y,v)
% posx=[];posy=[];
% for i=1:length(X)
%     x=X{1,i};
%     y=Y{1,i};
in=inpolygon(y,x,v(:,1),v(:,2));
posx=x(in > 0);
posy=y(in > 0);
% posx=cat(1,posx,posx1);
% posy=cat(1,posy,posy1);
end