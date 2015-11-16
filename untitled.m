%this code is to generate points for checking the orderparameters
clear all
x(1,:)=[3,3,3];

y(1,:)=[2,6,8];%randi(10,1,3);

xc=sum(x)/3;
yc=sum(y)/3;

for j=1:3;
   
 pose2centx(1,j)=x(1,j);%-xc;
 pose2centy(1,j)=y(1,j);%-yc;
 
 unitvec(j,1)=pose2centx(1,j)/norm(abs(pose2centx(1,j)):abs(pose2centy(1,j)));
 unitvec(j,2)=pose2centy(1,j)/norm(abs(pose2centx(1,j)):abs(pose2centy(1,j)));
 
 a=pose2centx(1,j);
 b=pose2centy(1,j);
 
 r(1,j)=sqrt(a^2+b^2);


end
Q_loc_estimateX(1,:)=pose2centx(1,:);
Q_loc_estimateY(1,:)=pose2centy(1,:);
   
c=0;
for j=1:3
    d=0;t=30;
    for i=1:241
%          Q_loc_estimateX(i,:)=x(1,:)+c;
%          Q_loc_estimateY(i,:)=y(1,:)+c;
   % c=c+1;
  % if i<=10
        int(1,j)=r(1,j)/60;
        if j && i == 1
        Q_loc_estimateX(i,j)=Q_loc_estimateX(i,j);
        Q_loc_estimateY(i,j)=Q_loc_estimateY(i,j);
        else
             % 1st quadrant
                if Q_loc_estimateX(i-1,j) && Q_loc_estimateY(i-1,j) >= 0
                    if abs(Q_loc_estimateX(i-1,j))+int(1,j) >=r(1,j)
                    
                z=r(1,j)-Q_loc_estimateX(i-1,j);
                in=z-int(1,j)+Q_loc_estimateX(i-1,j);
                Q_loc_estimateX(i,j)=r(1,j);%in            
                Q_loc_estimateY(i,j)=0;%(sqrt(abs((r(1,j)^2)-(Q_loc_estimateX(i,j))^2)));
                    else
                    Q_loc_estimateX(i,j)=Q_loc_estimateX(i-1,j)+int(1,j);
                    Q_loc_estimateY(i,j)=sqrt(abs((r(1,j)^2)-(Q_loc_estimateX(i,j))^2));
                    end
                end%else
           
               % 2nd quandrant
               if Q_loc_estimateX(i-1,j) <= 0 && Q_loc_estimateY(i-1,j) >= 0
                    Q_loc_estimateX(i,j)=Q_loc_estimateX(i-1,j)+int(1,j);
                    Q_loc_estimateY(i,j)=sqrt(abs((r(1,j)^2)-(Q_loc_estimateX(i,j))^2));
               end
               % else
                %3rd quadrant
            if Q_loc_estimateX(i-1,j) && Q_loc_estimateY(i-1,j) < 0
                
                if abs(Q_loc_estimateX(i-1,j))+int(1,j) >= r(1,j)
                
                z=r(1,j)-abs(Q_loc_estimateX(i-1,j));
                in=int(1,j)-z+Q_loc_estimateX(i-1,j);
                Q_loc_estimateX(i,j)=-r(1,j);%in;             
                Q_loc_estimateY(i,j)=0;%sqrt(abs((r(1,j)^2)-(Q_loc_estimateX(i,j))^2));
                else
                    Q_loc_estimateX(i,j)=Q_loc_estimateX(i-1,j)-int(1,j);
                    Q_loc_estimateY(i,j)=-(sqrt(abs((r(1,j)^2)-(Q_loc_estimateX(i,j))^2)));
                end
            end
           % else
                %4th quadrant
                if Q_loc_estimateX(i-1,j) >0 && Q_loc_estimateY(i-1,j) <= 0
                     Q_loc_estimateX(i,j)=Q_loc_estimateX(i-1,j)-int(1,j);
                    Q_loc_estimateY(i,j)=-(sqrt(abs((r(1,j)^2)-(Q_loc_estimateX(i,j))^2)));
                end
            end     
        end
   %end
%        for i=31:40
%            Q_loc_estimateX(i,j)=(Q_loc_estimateX(i-1,j))+10;
%            Q_loc_estimateY(i,j)=(Q_loc_estimateY(i-1,j))+10;
%        end
%        
%        %else
%           for i=41:50
%            Q_loc_estimateX(i,j)=randi(100,1);
%            Q_loc_estimateY(i,j)=randi(100,1);
%            end
        %end
      
  % end
%         l=((r(1,j)^2)-(C_locx(i,j)^2))
%        % pause 
%         
%         if l>0
%            
%         C_locy(i,j)=sqrt(abs((r(1,j)^2)-(C_locx(i,j)^2)));
%         d=d+int(1,j);
%         else
%             
%              C_locy(i,j)=-1*sqrt(abs((r(1,j)^2)-(pose2centx(1,j)+t)^2));
%            t=t-int(1,j);
%            d=t;
%         end
%         
         
%        if C_locy(i,j) > 0
%           d=d+dia(1,j);
%        else 
%            d=d-dia(1,j);
%        end
       
    end
%end
 %results
 clf;
 plot(Q_loc_estimateX,Q_loc_estimateY,'b-');
 figure(gcf)
 %pause
 %plot(0:1,order_parameter,order_parameter2,'p.')
