tic;
Q_loc_estimateX1(1:length(Q_loc_estimateX(:,1))-1,1:size(Q_loc_estimateX,2))=Q_loc_estimateX(2:end,:);
Q_loc_estimateY1(1:length(Q_loc_estimateX(:,1))-1,1:size(Q_loc_estimateX,2))=Q_loc_estimateY(2:end,:);
d(:,:,1)=Q_loc_estimateX1-Q_loc_estimateX;
d(:,:,2)=Q_loc_estimateY1-Q_loc_estimateY;
toc
%%
tic
 centroid_drctn(length(dx(:,1)),2)=nan;
for i=1:length(dx(:,1))
   
    d1(1,:)=d(i,~isnan(d(i,:,1)));
    d1(2,:)=d(i,~isnan(d(i,:,2)));
    
    centroid_drctn(i,1) = sum(d1)./norm(d1);
    centroid_drctn(i,2) = sum(d1)/length(d1);
    clear d1 d2;
end
toc