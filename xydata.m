
x=[];y=[];
for i=1:length(X)
    x1=X{1,i};
    y1=Y{1,i};
    x=cat(1,x,x1);
    y=cat(1,y,y1);
end