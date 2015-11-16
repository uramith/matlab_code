
clear x y z;

c_list = ['r' 'b' 'g' 'c' 'm' 'y'];
for i=1:length(mean_opvalue(:,1))
x=[1:length(mean_opvalue(1,:))];
y(1,1:length(mean_opvalue(1,:)))=i;
z=mean_opvalue(i,:);
Cz = mod(i,6)+1; %pick color
plt = plot3(x,y,z,'color',c_list(Cz));hold on;
end

xlabel('Distance from the fishe (in pixels)');
ylabel('Frame No.');
zlabel('Order Parameter value');
set(gca,'XTickLabel',[distmin:10:distmax])