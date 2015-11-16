
function [pos,v,a]=makecells(data,steps)
v{max(data(:,1))}=[];
pos{max(data(:,1))}=[];
a{max(data(:,1))}=[];
    for i=1:max(data(:,1))
    
    clear index test_frame;
    index=find(data(:,1) == i);
    test_frame=(data(index,:));
    tp= (~isnan(test_frame(:,7:8)).*test_frame(:,3:4));
    tp(tp ==0)=nan;
    indx=find(~isnan(tp(:,1)));
    tp1=tp(indx,:);
    pos{i}=tp1;
    v{i}=test_frame(:,7:8);
    a{i}=(test_frame(:,3:4)-test_frame(:,5:6))/(steps/30)^2;
   
    end
end