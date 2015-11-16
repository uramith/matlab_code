% c=0;
% for i=1:2:(2*length(X))
% c=c+1;
% for j=1:1:length(X{1,c})
% ps(j,i)=Y{1,c}(j);
% ps(j,i+1)=X{1,c}(j);
% end
% end
c=0;
 for i=1:length(vectorx(:,1))
c=c+1;d=0;
for j=1:length(vectorx(1,:))
    d=d+2;
vec(c,d-1)=vectorx(i,j);
vec(c,d)=vectory(i,j);
end
 end