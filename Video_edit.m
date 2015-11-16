 clear all;
 vidobj=VideoReader('clip1.avi')
vidwrite=VideoWriter('clip1_1-300.avi','Uncompressed AVI')
open(vidwrite);
for i=1:nframe
    img_tmp=read(vidobj,i);
    imshow(img_tmp);
    
    curframe=getframe;
    writeVideo(vidwrite,curframe);
    
end
close(vidwrite);