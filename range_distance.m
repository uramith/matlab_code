%% find fishes within the distance + or - r using 'rangesearch'

function [posid] = range_distance(position,minr,maxr,bwidth)
% maxr=200;
% bwidth=20;
posid{floor((maxr-minr)/bwidth)+1}={};
dm=0;
    for r= minr:bwidth:maxr
        dm=dm+1;
    idx1=rangesearch(position,position,r);
    idx2=rangesearch(position,position,r+bwidth);
    postnid{length(idx1)}=[];
        for z=1:length(idx1)
            if r==0 
                %cm=cell2mat(idx1);
                postnid{z}= idx1{z};
            else
            postnid{z}=idx2{z}(1,length(idx1{z})+1:end);
            end
        end
        posid{dm}=postnid;
        clear idx1 idx2;
    end
    
end