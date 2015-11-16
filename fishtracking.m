clear all;
%videoread=vision.VideoFileReader('clip1.avi');
videoread=VideoReader('MixedM.avi')
nframe=videoread.NumberOfFrames;
% writerObj=VideoWriter('/home/amith/project/fishtrack.avi');
% open(writerObj);
hsizeh = 32;
sigma= 6;
h = fspecial('log', hsizeh, sigma);

%to get ROI
clf;
imgframe = read(videoread,10);
[x, y, BW, xi,yi]=roipoly(imgframe);

steps=1;
c=0; %c=c+1;
%while ~isDone(videoread);
initial_frame=1;
nframe=nframe;
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
     img1(indexu) = 250 ;

     index1=find(img1 > 110);
     img(index1) = 250;
     
     
    
    blob_img = conv2(img,h,'same');%imshow(blob_img);
    idx = find(blob_img < .9);
    blob_img(idx) = nan ;
    
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
%     close all;
end

%clear all;


%fish_tracker
     