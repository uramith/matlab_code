load('clip11_track')
OP_polarization
OP_angular_momentum
t(:,1)=1:3:length(order_parameter)*3;
t(:,2)=order_parameter(:,1);
t(:,3)=order_parameter2(:,1);

figure
plot(t(:,1),t(:,2),t(:,1),t(:,3))
%plot(1:3:length(order_parameter)*3,order_parameter,1:3:length(order_parameter)*3,order_parameter2)
xlabel('frames');
ylabel('OP values');
title('clip11');
legend('polarization','angular momentum','Location','NorthEast');
save('/home/amith/project/plots/clip11_OP_data','order_parameter','order_parameter2');

csvwrite('/home/amith/project/plots/clip11_OP.dat',t)