clear mean_opvalue2;
for i=1:max(data_sheet(:,1))
 clear t index ft;
 i
 index=find(data_sheet(:,1) == i);
 ft=data_sheet(index,:);
 t=data_sheet(index,3:4);
 c=0;
 min_nibr=2; max_nibr=50;
    for Rr=min_nibr:1:max_nibr
        clear id dist;
 %Rr=50;
 [id,dist]=knnsearch(t,t,'k',Rr) ;
 c=c+1;
        for j=1:length(id)
        clear nibrs unitvector idx;
        nibrs=ft(id(j,:),:);
            
                for I=1:length(nibrs(:,1))
                unitvector(I,1:2) = nibrs(I,7:8)./norm(nibrs(I,7:8));
                end
                
            idx=find(isnan(unitvector));
            unitvector(idx)=0;
            opvalue(i,j)=sqrt(abs(sum((sum(unitvector)./length(unitvector(:,1))).^2)));
            end
        clear indexu; indexu=find(opvalue(i,:) > 0);
        op=opvalue(i,indexu);
        mean_opvalue2(i,c)=mean(op);
        
    end
end
clear mean_opvalue_frame1;for i=1:length(mean_opvalue(1,:))
mean_opvalue_frame1(1,i)=mean(mean_opvalue(4:end,i));
end

figure, plot(mean_opvalue_frame1,'bo');
xlabel('Distance from fish');
ylabel('Avg value of Order parameter');
figure, %subplot(2,1,1);   
Q=pcolor(mean_opvalue2);
title('order parameter2');
xlabel('nearest fishes');
ylabel('Frame No.');
set(gca,'XTickLabel',[min_nibr:2:max_nibr]);
set(Q,'Line','none');
cmp=colormap(hot);
cb=colorbar;
%set(cb,'YTicklabel',[0.1 : 0.1 : 1])
% subplot(2,1,2);
% pcolor(mean_opvalue_frame)

%--------------------------------------------------------------------------
% smooth 

h=[.025 .01;.05 .025 ; .075 .05 ; .1 .075; .075 .05 ; .05 .025;.025 .01 ];
C1=conv2(mean_opvalue2,h,'same');
figure, Q1=pcolor(C1);
title('order parameter2 (smooth)');
xlabel('nearst fishes');
ylabel('Frame No.');
hold on;
set(gca,'XTickLabel',[distmin:10:distmax]);
set(Q1,'Line','none');
cmp=colormap(hot);
cb=colorbar;
%set(cb,'YTicklabel',[0.1:0.1:1])

