%for distance between neares neighbour
clear n d pos;
%nnibr_dist=zeros(160,length(X));
for i=1:1:length(X);
    pos=X{1,i};
    pos(:,2)=Y{1,i};
[n d]=knnsearch(pos,pos,'k',2,'NSMethod','exhaustive');
%nnibr_dist(1:length(d),i)=d(:,2);
avg_dist(1,i)=mean(d(:,2));
end
            