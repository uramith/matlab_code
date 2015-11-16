% This code converts raw tracked data into cells. each cell contains x and
% y components.


d=0;b=0;
for i=1:length(Q_loc_estimateX(1,:))
   d=d+2; c=0;l=0; X=zeros;Y=zeros;
    for j=1:length(Q_loc_estimateX(:,1))
       
        if ~isnan(Q_loc_estimateX(j,i))
            c=c+1;
            X(c,1)=Q_loc_estimateX(j,i);
            X(c,2)=Q_loc_estimateY(j,i);
        end
            if ~isnan(Q_loc_estimateX(i,j))
                l=l+1;
            Y(l,1)=Q_loc_estimateX(i,j);
            Y(l,2)=Q_loc_estimateY(i,j);
            end
       % end
%         X=Q_loc_estimateX(i,:)';
%         Y=Q_loc_estimateY(i,:)';
%          Y=Xcord;
%          Y=Ycord;
    end
   
    if X > 0
        b=b+1;
    Xcell{1,b}=X;   %Each cell contains positions
    Ycell{1,b}=Y;   %Each cell contains positions of tracked data wrt frame
    end
    %clear X
end
        