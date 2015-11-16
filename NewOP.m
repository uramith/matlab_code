% New Order Parameter 

for i=1:max(data_sheet(:,1))
 clear t index ft;
 
 index=find(data_sheet(:,1) == i);
 ft=data_sheet(index,:);
 t=data_sheet(index,3:4);
 distmin=30;
 distmax=200;
 c=0;
    for Rr=distmin:10:distmax
        clear id dist;
 %Rr=50;
 [id,dist]=rangesearch(t,t,Rr);
 c=c+1;
        for j=1:length(id)
        clear nibrs unitvector idx;
        nibrs=ft(id{j,1},:);
            if length(nibrs(:,1)) == 1
                opvalue(i,j)=1;
            else
                for I=1:length(nibrs(:,1))
                unitvector(I,:) = nibrs(I,7:8)./norm(nibrs(I,7:8));
                end
            idx=find(isnan(unitvector));
            unitvector(idx)=0;
            opvalue(i,j)=sqrt(sum((sum(unitvector)./length(unitvector(:,1))).^2));
            end
        clear indexu; indexu=find(opvalue(i,:) > 0);
        op=opvalue(i,indexu);
        mean_opvalue(i,c)=mean(op);
        end
    end
end

clear indx; indx=find(isnan(mean_opvalue));
    mean_opvalue(indx)=0;
    
clear mean_opvalue_frame;for i=1:length(mean_opvalue(1,:))    
mean_opvalue_frame(1,i)=mean(mean_opvalue(2:end,i));
end

%--------------------------------------------------------------------------
%Plotting
figure, plot(mean_opvalue_frame(1,:),'ro');
xlabel('Distance from fish');
ylabel('Avg value of Order parameter');
figure, %subplot(2,1,1);   
P=pcolor(mean_opvalue);
title('order parameter');
xlabel('Distance from fish (in pixels)');
ylabel('Frame No.');
set(gca,'XTickLabel',[distmin:10:distmax]);
set(P,'EdgeColor','none');
cmp=colormap(hot);
cb=colorbar;
%set(cb,'YTicklabel',[0.1 : 0.1 : 1])
% subplot(2,1,2);
% pcolor(mean_opvalue_frame)

%--------------------------------------------------------------------------
% smooth 

h=[.025 .01;.05 .025 ; .075 .05 ; .1 .075; .075 .05 ; .05 .025;.025 .01 ];
C1=conv2(mean_opvalue,h,'same');
figure, P1=pcolor(C1);
title('order parameter (smooth)');
xlabel('Distance from fish (in pixels)');
ylabel('Frame No.');
hold on;
set(gca,'XTickLabel',[distmin:20:distmax]);
set(P1,'Line','none');
cmp=colormap(hot);
cb=colorbar;
%set(cb,'YTicklabel',[0.1:0.1:1])
