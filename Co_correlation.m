%% To find Co(normalising factor) 

function [Co_coreln]=Co_correlation(u)
    for k=1:length(u)
        
        Co_coreln(k,:) = dot(u{1,k},u{1,k});
        
    end
end
