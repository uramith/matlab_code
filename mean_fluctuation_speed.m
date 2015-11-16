%% Mean fluctuation with mod v


function [ui] = mean_fluctuation_speed(V)
N=length(find(~isnan(V(:,1))));
V(isnan(V))=0;
    for q=1:N        
        ui(q,:)= norm(V(q,:)) - norm(sum(V))/N;
    end
    
end