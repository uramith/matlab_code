function [mnve]=average_velocity(data_sheet)
% clear t;
t=[];
    for I=1:max(data_sheet(:,1))
    clear t dt vel_vector ve;
    t=find(data_sheet(:,1) == I);

    dt=(data_sheet(t,:));
    vel_vector = dt(:,7:8); 

    % nbr_vel_mean %to find mean of nearest neighbor 
    %ve=zeros(length(avgv(:,1)),1);
    % for i=1:length(avgv(1,:))

        ve=sqrt(vel_vector(:,1).^2+vel_vector(:,2).^2);
        %ve=ve';
        clear veid ;
        veid=find( isnan (ve));
        ve(veid)= 0;
        %ve=ve';
    % end
    mnve(I,1)=sum(ve)/(length(ve)-length(veid)); 
    mnve(I,2)=std(ve);
    mnve(I,3)=var(ve);
    end
end