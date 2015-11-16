function [ndist] = perp_distance(lpos,x1,x2,y1,y2)
        ndist=[];
    for k=1:length(lpos(:,1))
        ndist(k,1)=point_to_line([lpos(k,:) 0],[x1 y1 0],[x2 y2 0]);
    end
end