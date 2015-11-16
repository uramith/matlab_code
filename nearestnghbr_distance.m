function [frame_nrstnibr_dist,frame_avgdist]= nearestnghbr_distance(data_sheet)
    for i=1:(max(data_sheet(:,1)))
%     i
    % Get the positions with respect to frame
    clear index;
    index= data_sheet(:,1) == i;
    t=data_sheet(index,3:4);

    % search for nearst neighbor
        if size(t,1) > 1
            [~,nD]=knnsearch(t,t,'K',2); % search for nearest neighbor
            frame_nrstnibr_dist(i,1)=mean(nD(:,2)); % avg distance of nearest neighobr in respective frame
        else
            frame_nrstnibr_dist(i,1)= 0;
        end

    % search with in some radius for neighbor.
    rds=0;
        for J=1:15
            rds=rds+35;
        clear id rdist;
        [id,rdist]=rangesearch(t,t,rds);

            for ii=1:length(id)
                ind_meandist(ii,i) = sum(rdist{ii,1})/(length(id{ii,1})-1);
%                 clear indx; indx= ;
                ind_meandist(isnan(ind_meandist))=0;


            end
        frame_avgdist(J,i) = sum(ind_meandist(:,i))/length(id);
        end
    end
end
