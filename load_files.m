files=dir('/home/amith/project/EPTilapia/datasheet/*.mat');
for i=1:length(files)
    datsht{1,i}=load(files(i).name);
end 

%%
files=dir('/home/amith/mean*.mat');
for i=1:length(files)
    mn{1,i}=load(files(i).name);
end 