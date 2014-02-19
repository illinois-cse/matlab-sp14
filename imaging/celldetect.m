%% Example of cell boundary detection.
%% Load cell image
% Read in the cell and display it.
I=imread('cell.png');
figure, imshow(I), title('original image');
text(size(I,2),size(I,1)+15,'Image courtesy Ed Uthman','FontSize',10, 	'HorizontalAlignment','right');

%% Detect cell edges
% Detect the edges within the cell.  This uses the gradient image and a threshold to create a binary mask of the cell.
[~, threshold] = edge(I, 'sobel');
fudgeFactor = .5;
BWs = edge(I,'sobel', threshold * fudgeFactor);
figure, imshow(BWs), title('binary gradient mask');

%% Dilate detected edges
% Thicken the lines using the structural element tool (strel) and the image dilation tool (imdilate).
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);
figure, imshow(BWsdil), title('dilated gradient mask');

%% Fill interior gaps
% Now we fill the interior gaps of the cell.
BWdfill = imfill(BWsdil, 'holes');
figure, imshow(BWdfill);
title('binary image with filled holes');

%% Smooth away noise
% Finally, we smooth the object to remove the noisy disconnected globs from outside the cell.
seD = strel('diamond',1);
BWfinal = imerode(BWdfill,seD);
BWfinal = imerode(BWfinal,seD);
figure, imshow(BWfinal), title('segmented image');

%% Display results
% Superimpose the edge detection over the original image to see the results of our automatic detection script.
BWoutline = bwperim(BWfinal);
Segout = I;
Segout(BWoutline) = 0;
figure, imshow(Segout), title('outlined original image');