clear all;
%videoread=vision.VideoFileReader('clip1.avi');
videoread=VideoReader('11420400-1.m4v')
nframe=videoread.NumberOfFrames;
% writerObj=VideoWriter('/home/amith/project/fishtrack.avi');
% open(writerObj);img2 = img_tmp(:,:,2);

hsizeh = 100;
sigma= .45; %use 1.6 for 1080p and 3 or 3.5 for 720p
h = fspecial('log', hsizeh, sigma);

gh=[.2 .5 .2;.5 1 .5;.2 .5 .2];
%to get ROI
clf;
imgframe = read(videoread,10);
[x, y, BW, xi,yi]=roipoly(imgframe);

steps=3;
c=0; %c=c+1;
%while ~isDone(videoread);
initial_frame=3000;
nframe=4500;
for i=initial_frame:steps:nframe
    c=c+1
    %imgframe=step(videoread);blob_img = conv2(img,h,'same');imshow(blob_img);
    imgframe = read(videoread,i);
    img_tmp = double(imgframe); %load in the image and convert to double too allow for computations on the image
    img = img_tmp(:,:,1); %reduce to just the first dimension, we don't care about color (rgb) values here.
    
    
%     img(:,1:xi(1,1))=nan;img(1:yi(3,1),:)=nan;img(:,xi(3,1):end)=nan;img(yi(1,1):end,:)=nan;
%     img1 = img_tmp(:,:,1); img2 = img_tmp(:,:,2); img3 =img_tmp(:,:,3);
    img2 = img_tmp(:,:,2);
%     index = find(img < 120) ;%&& find(img < 15);
%     img(index) = 0;
     indexu=find(BW < 1);
     img2(indexu) = 0 ;

     index1=find(img2 < 95);
     img(index1) = 0;
     
     
    
    blob_img = conv2(img,h,'same');%figure,imshow(blob_img);
%     idx = find(blob_img < 1000);
%     blob_img(idx) = nan ;

%-----------------------------------------------------------------------
% 
% blob_img = conv2(blob_img,gh,'same');
% blob_img = conv2(blob_img,gh,'same');
% idx = find(blob_img < 2000);
% blob_img(idx) = 1000 ;
% 
% blob_imgu = conv2(blob_img,h,'same');
% indxu1=find(blob_imgu < 3500);
% blob_imgu(indxu1)=nan;
% %  imshow(blob_imgu);
% indecs=find(~isnan(blob_imgu));
% blob_imgu(indecs)=1;
% indecsu=find(isnan(blob_imgu));
% blob_imgu(indecsu)=0;
% clear cc stats centroids;
% cc=bwconncomp(blob_imgu);
% stats=regionprops(cc,'basic');
% centroids=cat(1,stats.Centroid);
% [Y{c}] = centroids(:,1);
% [X{c}] = centroids(:,2);

%---------------------------------------------------------------------

blob_img = conv2(img,h,'same');%figure,imshow(blob_img);


blob_img = conv2(blob_img,gh,'same');
blob_img = conv2(blob_img,gh,'same');
clear index indexu;
index=find(blob_img < 0);
blob_img(index)=0;
indexu=find(blob_img > 0);
blob_img(indexu)=1;
cc=bwconncomp(blob_img);
stats=regionprops(cc,'basic');
centrds=cat(1,stats.Centroid);
idn=find([stats.Area] > 800 );
centroids=centrds(idn,:);
[Y{c}] = centroids(:,1);
[X{c}] = centroids(:,2);

%---------------------------------------------------------------------
    %[zmax,imax,zmin,imin] = extrema2(blob_img);
%     [X{c},Y{c}] = ind2sub(size(blob_img),imax);
    count=length(X{c});
    count
%     pause
%-------------------------------------------------------------------------
    % Visualization
    %clf;


%     imshow(imgframe)
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
%      pause(0.1);
% %      close all;
end
% close(writerObj);
%tracking part


%save('ZFclip3_XY.mat','X','Y');
 fish_tracker;
 video_review;