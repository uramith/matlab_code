%nearest neighbour
clear frame_avgdist ind_meandist;
for i=1:(max(data_sheet(:,1)))

% Get the positions with respect to frame
clear index t;
index=find(data_sheet(:,1) == i);
t=data_sheet(index,3:4);

% search with in some radius for neighbor.
clear id rdist;
[id,rdist]=knnsearch(t,t,'k',2);% rangesearch(t,t,35);
for ii=1:length(id)
    ind_meandist(i,ii) = sum(rdist(ii,:))/(length(id(ii,:))-1);
    clear indx; indx=find(isnan(ind_meandist));
    ind_meandist(indx)=0;
    
    %pause
end
frame_avgdist(i,1) = sum(ind_meandist(i,:))/length(id);
%ind_meandist=ind_meandist';
end



% clf
% plot(t(:,1),t(:,2),'r.')
% hold on;
% a=t(n,:);
% c=t(n(1,1),:);
% plot(c(1,1),c(1,2),'bo');
% hold on;
% ctr=c-b(end);
% h=rectangle('Position',[ctr,65,65],'curvature',[1 1],'linestyle','-');