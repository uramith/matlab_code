%--------------------------------------------------------------------------
%This code is to find normalized angular momentum order parameter
%--------------------------------------------------------------------------

% to find centroid from tracked data:
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

% to save positions with respect to centroid
for i=1:length(Q_loc_estimateX(:,1))-1
    for j=1:length(Q_loc_estimateX(1,:))
    new_posx(i,j)=Q_loc_estimateX(i,j)-centrd(i,1);% x-component
    new_posy(i,j)=Q_loc_estimateY(i,j)-centrd(i,2);% y-component
    end
end
%--------------------------------------------------------------------------
% To get rid of NAN values
for i=1:length(new_posx(:,1))% for i=1:2:length(vec(1,:))
count=0;
    for j=1:length(new_posx(1,:))
       
        if ~isnan(new_posx(i,j))
            
            count=count+1;
            new_vectorx(i,count)=new_posx(i,j);
            new_vectory(i,count)=new_posy(i,j);
            trkcount(i,1)=count;
           
        end
    end
end
%--------------------------------------------------------------------------

% save x and y component in a single variable, odd column is x-component 
% and even is y-component.
c=0;
 for i=1:length(new_vectorx(:,1))
c=c+1;d=0;
for j=1:length(new_vectorx(1,:))
    d=d+2;
vec2centrd(c,d-1)=new_vectorx(i,j);
vec2centrd(c,d)=new_vectory(i,j);
end
 end
%--------------------------------------------------------------------------

% for unit vector from centroid
 for j=1:length(vec2centrd(:,1))
for i=1:2:length(vec2centrd(j,:))
    if (vec2centrd(j,i))~=0 % to avoid NAN values
unicntd(j,i)=(vec2centrd(j,i)/norm(vec2centrd(j,i:i+1)));% x-component
     else
    unicntd(j,i)=0;
    end
    
    if (vec2centrd(j,i+1))~=0 % to avoid NAN values
unicntd(j,i+1)=(vec2centrd(j,i+1)/norm(vec2centrd(j,i:i+1)));%y-component
   else
       unicntd(j,i+1)=0;
   end
end
 end
 
% to find cross product 
 for i=1:length(unicntd(:,1))-1
     for j=1:2:length(uni(i,:))
         vec_cross(i,j)=uni(i,j)*unicntd(i,j+1);
         vec_cross(i,j+1)=-(uni(i,j+1)*unicntd(i,j));
     end
 end
        
 % normalization and result

for j=1:length(vec2centrd(:,1))-1
     for i=1:2:length(vec_cross(j,:))
    if (vec_cross(j,i)) == 0
        n(j,i)=0;
        n(j,i+1)=0;
    else
n(j,i)=(vec_cross(j,i)/norm(vec_cross(j,i:i+1)));
n(j,i+1)=(vec_cross(j,i+1)/norm(vec_cross(j,i:i+1)));
    
    end
end
order_parameter2(j,1)=sqrt((sum(n(j,1:2:end))/trkcount(j,1))^2+(sum(n(j,2:2:end))/trkcount(j,1))^2);
end

