clear all;
%videoread=vision.VideoFileReader('clip1.avi');
videoread=VideoReader('Apr30_EPandTillapia.avi')
nframe=videoread.NumberOfFrames;
% writerObj=VideoWriter('/home/amith/project/fishtrack.avi');
% open(writerObj);
hsizeh = 32;
sigma= 6;
h = fspecial('log', hsizeh, sigma);

c=0; %c=c+1;
%while ~isDone(videoread);
for i=1:15:nframe
    c=c+1
    %imgframe=step(videoread);
    imgframe = read(videoread,i);
    img_tmp = double(imgframe); %load in the image and convert to double too allow for computations on the image
    img = img_tmp(:,:,1); %reduce to just the first dimension, we don't care about color (rgb) values here.
    img(1:162,:)=nan;img(640:720,:)=nan;img(:,1:53)=nan;img(:,1260:1280)=nan;
%     img1 = img_tmp(:,:,1); img2 = img_tmp(:,:,2); img3 =img_tmp(:,:,3);
%     index = find(img > 65) ;%&& find(img < 15);
%     img(index) = 100;
% %     index1=find(img2 > 50);
% %     img(index1)=140;
    blob_img = conv2(img,h,'same');imshow(blob_img);
    %clf;
    idx = find(blob_img < .6);
    blob_img(idx) = nan ;
    clear bp;
    bp = find(blob_img >= .6);
    
    if length(bp) > 2
    [zmax,imax,zmin,imin] = extrema2(blob_img);
    [X{c},Y{c}] = ind2sub(size(blob_img),imax);
    count=length(X{c});
    count
    %pause
    
%     clf;
%     imshow(imgframe)
%     hold on 
%     %labels=0;
%             for j = 1:length(X{c})
%        %labels=labels + 1;
%       % labels=cellstr( num2str(j));
%          plot(Y{c}(j),X{c}(j),'r.','MarkerSize',5) 
%       % text(Y{c}(j),X{c}(j),labels,'VerticalAlignment','bottom','HorizontalAlignment','left','FontSize',.1)
%         
%             end
    end
   %f=getframe;
   %pause(0.01);
    
%    writeVideo(writerObj,f);
    
end
% close(writerObj);
%tracking part


%

%clear all;


%fish_tracker
