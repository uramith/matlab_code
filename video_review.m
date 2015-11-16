c=0;
% centroid;
vidwrite=VideoWriter('/home/amith/');
vidwrite.FrameRate=10;
open(vidwrite);
% nframe=3000+471*steps;
for i=initial_frame:steps:nframe
c=c+1
% c=c+1;
% load the image
% img_tmp = double(imread(f_list(t).name));
img_tmp=read(videoread,i+601);
clf;
%img = imread(f_list(t).name);
imshow(img_tmp);
hold on;
% plot(Y{c}(:),X{c}(:),'r.'); % the actual tracking
% T = size(Q_loc_estimateX,2);
Ms = [1]; %marker sizes
c_list = ['r' 'b' 'g' 'c' 'm' 'y'];
for Dc = 1:length(Q_loc_estimateX)
if ~isnan(Q_loc_estimateX(c,Dc))
Sz = mod(Dc,1)+1; %pick marker size
Cz = mod(Dc,6)+1; %pick color
            if c < 21
                st = c-1;
            else
                st = 19;
            end
tmX = Q_loc_estimateX(1:c,Dc);%(c-st:c,Dc);
tmY = Q_loc_estimateY(1:c,Dc);%(c-st:c,Dc);
plot(tmY,tmX,'.-','markersize',Ms(Sz),'color',c_list(Cz),'linewidth',1)
% plot(Y{c},X{c},'.r')
% plot(centrd(c,2),centrd(c,1),'b.')
axis off
end
    
end
curframe=getframe;
writeVideo(vidwrite,curframe);

%  pause(0.05)
%}
if c == 96
    break;
end
end
close(vidwrite);