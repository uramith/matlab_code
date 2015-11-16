%for saving in order
clear data_sheet;

% To make a vector components from the tracked data:
clear Vx Vy;
Vx=zeros(size(Q_loc_estimateX)-[1 0]);
Vy=zeros(size(Q_loc_estimateY)-[1 0]);
for i=1:length(Q_loc_estimateX(:,1))-1
Vx(i,:)=(Q_loc_estimateX(i+1,:)-Q_loc_estimateX(i,:))/(steps/30);
Vy(i,:)=(Q_loc_estimateY(i+1,:)-Q_loc_estimateY(i,:))/(steps/30);
end


vx(2:length(Vx(:,1))+1,1:length(Vx(1,:)))=Vx;
vy(2:length(Vx(:,1))+1,1:length(Vx(1,:)))=Vy;
clear Vx Vy;
Vx=vx; Vy=vy;
clear vx vy;

d=0;

for i=1:length(Vx(:,1))
    c=0;
       for j=1:length(Vx(1,:))
            if (Q_loc_estimateX(i,j)) > 0
            d=d+1;
            data_sheet(d,1)=i; %frame nbr
                if (Q_loc_estimateX(i,j)) > 0
                c=c+1;
                data_sheet(d,2)=c; %identity
                data_sheet(d,3)=Q_loc_estimateX(i,j); % x position
                data_sheet(d,4)=Q_loc_estimateY(i,j); % y position
                    
                    if i==1
                        data_sheet(d,5)=Q_loc_estimateX(i,j);
                        data_sheet(d,6)=Q_loc_estimateY(i,j);
                    else
                        data_sheet(d,5)=Q_loc_estimateX(i-1,j); % x position
                        data_sheet(d,6)=Q_loc_estimateY(i-1,j); % y position
                    end
                data_sheet(d,7)=Vx(i,j); %velocity x-component
                data_sheet(d,8)=Vy(i,j); %velocity y-component
                else
                c=c;
                end
            end
      end
end

% avg_velocity 
        
        