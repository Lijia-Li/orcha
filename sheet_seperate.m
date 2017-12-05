% sheet seperate function

% read image 
sheetImage = imread('orcha_music_png/4840053-Silent_Night_Holy_Night4beat/4840053-Silent_Night_Holy_Night4beat-1.jpg');


% since the sheet image is grey scare
[rows, columns, numberOfColorBands] = size(sheetImage);
if numberOfColorBands > 1
	% It's not really gray scale like we expected - it's color.
	% Convert it to gray scale by taking only the green channel.
	sheetImage = rgb2gray(sheetImage(:, :, 2)); % Take green channel.
end
% figure; 
% imshow(sheetImage);
% title('Image of a complete melody');

% detect features 
corners = detectHarrisFeatures(sheetImage, 'MinQuality',0.5);
imshow(sheetImage); 
hold on;
plot(corners.selectStrongest(50));
hold off;




