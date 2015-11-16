% This is to find centroid from the detection data:
% c=0;r=0;
% for i=1:2:length(ps(1,:));c=0;r=r+1;
% for j=1:1:length(ps(:,i))
% if ps(j,i)>0
% c=c+1;
% end
% end
% centrd(r,1)=sum(ps(:,i))/c;
% centrd(r,2)=sum(ps(:,i+1))/c;
% end

%this is to find centroid from tracked data:
for i=1:length(Q_loc_estimateX(:,1))
    c=0;sumx=0;sumy=0;
    for j=1:length(Q_loc_estimateX(i,:))
        if ~isnan(Q_loc_estimateX(i,j))
            c=c+1;
            sumx=sumx+Q_loc_estimateX(i,j);
            sumy=sumy+Q_loc_estimateY(i,j);
        end
    end
    centrd(i,1)=sumx/c;
    centrd(i,2)=sumy/c;
end
