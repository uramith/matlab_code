
clist=[ 'r' 'g' 'b' 'c' 'm' 'k' ];
clear meanve m mean_vel;
r=0;
for id=initial:final
    r=r+1;
    m=[]; % mean={};
    m=average_velocity(sept{id}.data_sheet);
    mean_vel{r}=struct('avg',{m(:,1)},'std',{m(:,2)},'var',{m(:,3)});
    meanve(1,r)= mean(m(:,1));
    n=mod(r,6)+1;
    plot(m(:,1),'color',clist(n)); hold on;
    id 
end
hold off;
figure, plot(meanve,'r:*');