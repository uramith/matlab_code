index=find(data_sheet(:,1) == 1);
t=data_sheet(index,3:4);
x=t(:,1);
y=t(:,2);
dt=delaunayTriangulation(x,y);
E=edges(dt);
P=dt.Points;


%% 18 jul 14 for speed
v=0;
for F=1:nF
if ~isnan(Q_estimate(:,F))
v=v+1;
Q_est(:,v)=A*Q_estimate(:,F)+B*u;
else v=v;end

end

%%
for nf=1:nF
if ~isnan(Q_estimate(1,nf))
Q_loc_estimateX(c,mod(nf,200)+1)=Q_estimate(1,nf);
Q_loc_estimateY(c,mod(nf,200)+1)=Q_estimate(2,nf);
end
end
