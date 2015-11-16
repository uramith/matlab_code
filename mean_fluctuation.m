%mean fluctuation
function [ui] = mean_fluctuation(V)
N=length(find(~isnan(V(:,1))));
V(isnan(V))=0;
    for q=1:N        
        ui(q,:)= V(q,:) - sum(V)/N;
    end
    
end