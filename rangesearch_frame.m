%new order paramter test
for i=2:length(Q_loc_estimateX);
t=Q_loc_estimateX(i,:)'; 
t=Q_loc_estimateY(i,:)';
[id rdist]=rangesearch(t,t,35);
nnOP_polarization;
