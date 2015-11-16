%--------------------------------------------------------------------------
% This code will calculate the order parameter.
%--------------------------------------------------------------------------
% To make a vector components from the tracked data:
for i=2:1:500%length(Q_loc_estimateX(:,1))-1
Vx(i,1:length(id{1,1}))=((Q_loc_estimateX(i,id{1,1}))-(Q_loc_estimateX(i-1,id{i,1})))/0.1;
Vy(i,1:length(id{i,1}))=((Q_loc_estimateY(i,id{i,1})-Q_loc_estimateY(i-1,id{i,1})))/0.1;
end

% position vector for each detected fish 
for i=1:length(Vx(:,1))
    count=0;
    for j=1:length(Vx(1,:))
       
        if ~isnan(Vx(i,j))
          
           count=count+1;
            vectorx(i,count)=Vx(i,j);
            vectory(i,count)=Vy(i,j);
        end
    end
            if count > 150
                trkcount(i,1)=150;
            else
            trkcount(i,1)=count;
            end
        %end
   % end
end

%  save x and y component in a single variable, odd column is x-component 
% and even is y-component.

c=0;
for i=1:length(vectorx(:,1))
c=c+1;d=0;
for j=1:length(vectorx(1,:))
    d=d+2;
vec(c,d-1)=vectorx(i,j);%x-component
vec(c,d)=vectory(i,j);%y-component
end
 end
%to find unit vector and result
 for j=1:length(vec(:,1))
for i=1:2:length(vec(j,:))
    if (vec(j,i))~=0
uni(j,i)=(vec(j,i)/norm(vec(j,i:i+1)));
     else
    uni(j,i)=0;
    end
    
    if (vec(j,i+1))~=0
uni(j,i+1)=(vec(j,i+1)/norm(vec(j,i:i+1)));
   else
       uni(j,i+1)=0;
   end
   
 end

order_parameter(j,1)=sqrt((sum(uni(j,1:2:end))/(length(id{i,1})))^2+...
    (sum(uni(j,2:2:end))/(length(id{i,1})))^2);

 end
 
 
 
%save('order_parameter_clip10.mat','order_parameter')

