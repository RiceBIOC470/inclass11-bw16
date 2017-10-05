% Inclass11

% You can find a multilayered .tif file with some data on stem cells here:
% https://www.dropbox.com/s/83vjkkj3np4ehu3/011917-wntDose-esi017-RI_f0016.tif?dl=0

% 1. Find out (without reading  the entire file) -  (a) the size of the image in
% x and y, (b) the number of z-slices, (c) the number of time points, and (d) the number of
% channels.

%% (a)
file='011917-wntDose-esi017-RI_f0016.tif';
reader=bfGetReader(file);
[reader.getSizeX,reader.getSizeY] %% 1024*1024

%% (b)
reader.getSizeZ %% 1

%% (c)
reader.getSizeT %% 68

%% (d)
reader.getSizeC %% 2

% 2. Write code which reads in all the channels from the 30th time point
% and displays them as a multicolor image.

chan=1
time=30
zplane=1
iplane=reader.getIndex(zplane-1,chan-1,time-1)+1;
img1=bfGetPlane(reader,iplane);

chan=2
iplane=reader.getIndex(zplane-1,chan-1,time-1)+1;
img2=bfGetPlane(reader,iplane);

img2show=cat(3,imadjust(img1),imadjust(img2),zeros(size(img1)));
imshow(img2show);

% 3. Use the images from part (2). In one of the channels, the membrane is
% prominently marked. Determine the best threshold and make a binary
% mask which marks the membranes and displays this mask. 

img_m=img1 > 800;
img0=uint16(img_m)*1000;
img2show_masked_channel1=cat(3, imadjust(img0), imadjust(img2), zeros(size(img1)));
imshow(img2show_masked_channel1)
imshow(imadjust(img0))

% 4. Run and display both an erosion and a dilation on your mask from part
% (3) with a structuring element which is a disk of radius 3. Explain the
% results.

img_erode=imerode(img_m, strel('disk',3));
img_dilate=imdilate(img_m, strel('disk',3));
img3=uint16(img_erode)*1000;
img4=uint16(img_dilate)*1000;
img2show_masked_channel1_erode=cat(3, imadjust(img3), imadjust(img2), zeros(size(img1)));
img2show_masked_channel1_dilate=cat(3, imadjust(img4), imadjust(img2), zeros(size(img1))); 
imshow(img2show_masked_channel1_erode);
imshow(img2show_masked_channel1_dilate);