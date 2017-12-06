% note this function/script is not finished yet. 
% this function try to use HOG feature extraction to detect where to slice
% the image in order to let machine read the music sheet in a continuous manner. 

% read image from a grey scale
sheetImage = imread('orcha_music_png/4840053-Silent_Night_Holy_Night4beat/4840053-Silent_Night_Holy_Night4beat-1.jpg');
[rows, columns, numberOfColorBands] = size(sheetImage);
if numberOfColorBands > 1
	% It's not really gray scale like we expected - it's color.
	% Convert it to gray scale by taking only the green channel.
	sheetImage = rgb2gray(sheetImage(:, :, 2)); % Take green channel.
end

% draw the image  
figure;
imshow(sheetImage);
title('Image of a complete melody');

% extract HOG freature 
[hog1,visualization] = extractHOGFeatures(sheetImage,'CellSize',[5 5]);

% visualize HOG feature 
subplot(1,2,1);
imshow(sheetImage);
subplot(1,2,2);
plot(visualization);

% Now as you can checked in hog1 that the vector equals to zero if the
% tested block is solid white color. That means if we can calculate the
% corresponding x,y coordinate of these zeros, then the music sheet will be
% easily sliced. However, reverse engineering on the calculation is at the
% moment unsuccessful. 



