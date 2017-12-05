% Read Images
img = rgb2gray(imread('orchaSearch/Snippet/melody_snippet.jpeg'));
I1 = rgb2gray(imread('orchaSearch/Snippet/melody_snippet.jpeg'));
I2 = rgb2gray(imread('orchaSearch/Scene/melody_scene.jpeg'));

% Extract Hog Features and generate hog visualization. This is just a test
% to help understand what hog extraction does.
[featureVector,hogVisualization] = extractHOGFeatures(img);
figure;
imshow(img); 
hold on;
plot(hogVisualization);

% Here is the hog extraction using CellSize. This is what we should focus
% on. The cell size right now is [5 5], you can play around with it and see
% the best cell size. 
% The following blocks are just tests to visualize what HOG extraction using CellSize.
[hog1,visualization] = extractHOGFeatures(I1,'CellSize',[5 5]);
figure;
subplot(1,2,1);
imshow(I1);
subplot(1,2,2);
plot(visualization);

[hog2,visualization] = extractHOGFeatures(I2,'CellSize',[5 5]);
figure;
subplot(1,2,1);
imshow(I2);
subplot(1,2,2);
plot(visualization);

% This is the real work. where we use HOGFeatures extracted based on
% Cellsize to match features. Just like the previous orchaSearch, this one
% use similar syntax and architecture.
[boxFeatures,boxPoints] = extractHOGFeatures(I1,'CellSize',[5 5]);
[sceneFeatures,scenePoints] = extractHOGFeatures(I2,'CellSize',[5 5]);

% [BUG EXPECTED]

% MatchFeature to compare the results from the snippet and scene images.
% However, you will certainly run into an error message saying
% "Expected FEATURES1 and FEATURES2 to have the same number of columns."
% You may want to look at the boxFeatures and scnenFeatures, where they do
% have different column sizes due to HOG extraction. We need to tweak the
% code that make them identical column size.

% Further research required in HOGextraction and matchFeatures.
boxPairs = matchFeatures(boxFeatures, sceneFeatures,'MatchThreshold',8,'Method','Approximate');