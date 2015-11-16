function [p]=midpoints(points)
c=0;
    for i=1:2:length(points)
        c=c+1;
        p(c,:)=(points(i,:)+points(i+1,:))/2;
        p=round(p);
    end
end