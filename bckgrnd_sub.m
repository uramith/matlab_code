imgframe = read(videoread,i);
imgframe1 =imgframe;
imgframe2 = read(videoread,i-30);
img=imgframe2-imgframe1;
bwimg=im2bw(img,0.04);
bwimg(BW < 1)= 0;
bwimg=medfilt2(bwimg);
conbw=bwconncomp(bwimg,8);
propimg=regionprops(bwimg,'Area','PixelIdxList');
stats=regionprops(conbw,'Area');
idx = find([stats.Area] < 100);
BW2 = ismember(labelmatrix(conbw), idx);
% imshow(BW2)
image=double(BW2);
image(image <1)= 250;
blob_img = conv2(image,h,'same');
% imshow(blob_img); 
blob_img(blob_img < 3) = nan;
% g = fspecial('log', hsizeh, 1);
% blob_img= conv2(blob_img,g,'same');
 imshow(blob_img)