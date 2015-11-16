

for i=1:(max(data_sheet(:,1)))

% Get the positions with respect to frame
clear index d;
index=find(data_sheet(:,1) == i);
d=data_sheet(index,3:8);
V = d(:,5:6);

end
