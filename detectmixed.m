clear all;
%videoread=vision.VideoFileReader('clip1.avi');
videoread=VideoReader('/home/amith/Desktop/August_28_3_4.avi')
nframe=videoread.NumberOfFrames;
% writerObj=VideoWriter('/home/amith/project/fishtrack.avi');
% open(writerObj);img2 = img_tmp(:,:,2);

hsizeh = 100;
sigma= 8; %use 1.6 for 1080p and 3 or 3.5 for 720p
h = fspecial('log', hsizeh, sigma);

%to get ROI
clf;
imgframe = read(videoread,10);
[x, y, BW, xi,yi]=roipoly(imgframe);

steps=3;
c=0; %c=c+1;
%while ~isDone(videoread);
initial_frame=4;
nframe=nframe;
for i=initial_frame:steps:nframe
    c=c+1
    %imgframe=step(videoread);blob_img = conv2(img,h,'same');imshow(blob_img);
    imgframe = read(videoread,i);
    img_tmp = double(imgframe); %load in the image and convert to double too allow for computations on the image
    img = img_tmp(:,:,1); %reduce to just the first dimension, we don't care about color (rgb) values here.

    %indexu=find(BW < 1);
    img(BW < 1) = 250 ;
    
    %index1=find(img2 > 110);
    img(img > 100) = 250;
%     img(img < 60) = 250;
    

    blob_img = conv2(img,h,'same');figure,imshow(blob_img);
    %idx = find(blob_img < .05);
    blob_img(blob_img < .1) = nan ;
%     bckgrnd_sub
%     blob_img(blob_img < .4) = nan ;
    
    [zmax,imax,zmin,imin] = extrema2(blob_img);
    [X{c},Y{c}] = ind2sub(size(blob_img),imax);
    count=length(X{c});
    count
%     pause
%-------------------------------------------------------------------------
%     % Visualization
%     clf;
% 
% 
%     figure,imshow(imgframe)
%     hold on 
%     labels=0;
%    for j = 1:length(X{c})
%        %labels=labels + 1;
%       % labels=cellstr( num2str(j));
%         plot(Y{c}(j),X{c}(j),'r.','MarkerSize',5) 
%       % text(Y{c}(j),X{c}(j),labels,'VerticalAlignment','bottom','HorizontalAlignment','left','FontSize',.1)
%         
%    end
% %    f=getframe;
% %       pause;
% %     
% %    writeVideo(writerObj,f);
%     pause;
    close all;
end
% close(writerObj);
%tracking part

save('detected_data_mah00396','X','Y','initial_frame','nframe','steps');
%save('ZFclip3_XY.mat','X','Y');
% fish_tracker;
% datasheet;
% save('trcked_data_MAH00396','Q_loc_estimateX','Q_loc_estimateY','X','Y','steps','initial_frame','nframe','data_sheet');
% NewOP;
% NewOP2;

