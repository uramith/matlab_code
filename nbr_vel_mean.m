nibr=dt(:,3:4);
for i=1:length(nibr(:,1))

clear nibrid nbt Indx nbrdistance;  
nbr_of_ngbr=5;
[nibrid,nbrdistance]=knnsearch(nibr,nibr(i,:),'k',nbr_of_ngbr);
nbt=dt(nibrid,3:end);
Indx=find(isnan(nbt));
nbt(Indx)=0;
nbrvel_mean(I,i) = mean(sqrt(nbt(:,5).^2+nbt(:,6).^2));

end