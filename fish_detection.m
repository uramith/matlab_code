
%Finding fishes !!
<<<<<<< HEAD
%this code uses blob analysis to find fishes from the video.
=======
%this code uses blob analysis to find objects. 
>>>>>>> analyze

%if you would like to use this code, please feel free, just remember to
%reference and tell your friends! :)
%requires matlabs image processing toolbox

%What the heck does this code do!?
% 1) Averaged background subtraction
% 2) Noise reduction via image smoothing using 2-d gaussian filter.
% 3) Threshold and point detection in binary image.

clear all;
close all;
%set(0,'DefaultFigureWindowStyle','docked') %dock the figures..just a personal preference you don't need this.

base_dir = '/home/amith/project/fish track/newsampe';


cd(base_dir);

%% get listing of frames so that you can cycle through them easily.
f_list =  dir('*tif');


%% initialize gaussian filter

%using fspecial, we will make a laplacian of a gaussian (LOG) template to convolve (pass over)
%over the image to find blobs!

hsizeh = 30 %you will need to iterative test these values two values. the bigger they are, the larger the blob they will find!
sigmah = 4   %
h = fspecial('log', hsizeh, sigmah)
%alpha=5
%h=fspecial('gaussian',hsizeh,sigmah)
%subplot(121); imagesc(h)
% subplot(122); mesh(h)
%colormap(jet)


%% iteratively (frame by frame) find flies and save the X Y coordinates!
X = cell(1,(100));%-length(f_list))); %detection X coordinate indice
Y = cell(1,(100));%-length(f_list)));  %detection Y coordinate indice

c=0; %dummy for counting 
for i =800:3:885
    c=c+1;
    img_real = (imread(f_list(i).name)); %just for plottin purposes
    img_tmp = double(imread(f_list(i).name)); %load in the image and convert to double too allow for computations on the image
    img = img_tmp(:,:,1); %reduce to just the first dimension, we don't care about color (rgb) values here.
 
    %do the blob filter!
    blob_img = conv2(img,h,'same');
    clf;
    %imshow(blob_img);
    %pause
    %threshold the image to blobs only: you'll need to decide what your
    %threshold level is..you can use your eyes or a histogram :P
    idx = find(blob_img < 2.3); 
   
    blob_img(idx) = nan ;
    
    %now we have an image of hills and valleys..some are distinct, some
    %overlap..but you can still see the peak...most of the time.
    %use this GREAT 2-d local max/ min finder 
    %http://www.mathworks.com/matlabcentral/fileexchange/12275-extrema-m-extrema2-m
    %it find the blob peak indices for this video, there should be ~11
    [zmax,imax,zmin,imin] = extrema2(blob_img);
    [X{c},Y{c}] = ind2sub(size(blob_img),imax);
    count=length(X{c});
    count
   % pause
    %for plotting
    %%{
    %clf
   % subplot(222);   
   %imagesc(blob_img)
    %   axis off
    
       %subplot(122)
    %labels=cellstr( num2str(1:(X{i}(j))));
   % imshow(img_real)
   % hold on
    %labels=0;
  % for j = 1:length(X{c})
       %labels=labels + 1;
       %labels=cellstr( num2str(j));
     %   plot(Y{c}(j),X{c}(j),'r.','MarkerSize',5) 
       %text(Y{c}(j),X{c}(j),labels,'VerticalAlignment','bottom','HorizontalAlignment','left','FontSize',.1)
        
   % end
    axis off
   % pause labels=cellstr( num2str(j));
    %}
    
    i
end
  
%save it!
%save('fishtrack_800-900.mat',  'X','Y')
%positions;
%centroid;


%now, move on to the multi object tracking code!









