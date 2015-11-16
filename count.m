for i=1:30
    c=0;d=0;
    %if ~isnan(Q_loc_estimateX(
    for j=1:length(Q_loc_estimateX(i,:))
        if ~isnan(Q_loc_estimateX(i,j))
            c=c+1;
            
        end
      
    end
     counttrk(i,1)=c;
     
end
counttrk