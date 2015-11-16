%%Find fishes with distance + or - r
function [posid] = rdistance(position)

pdistance=pdist(position);
distance=pdistance(:,1:length(position)-1)';
posid{length(position)}=[];
    for i=1:length(distance)
        fdistance=distance >= 35-5;
        
        f2distance=distance <= 35+5;
        poid= fdistance & fdistance2 ;
        ids=find(poid ==1 )
        posid{i}=ids;
    end
end



