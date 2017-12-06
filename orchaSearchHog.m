% Read Images
% I1 = rgb2gray(imread('orchaSearch/Snippet/melody_snippet.jpeg'));
I2 = rgb2gray(imread('orchaSearch/Scene/elice_scene.png'));

% hand drawn version
I1 = rgb2gray(imread('orchaSearch/Snippet/elice_snippet.png'));


% Visualize to test what cell size is the best fit
% HOGCellSizeTest(I2);


% Visualize orgion image's HOG features
[~, boxVisualization] = extractHOGFeatures(I1,'CellSize',[4 4]);
[~,sceneVisualization] = extractHOGFeatures(I2,'CellSize',[4 4]);
% HOGVisualization(I1, boxVisualization, 'snippet HOG visualization', 1);
% HOGVisualization(I2, sceneVisualization, 'scene HOG visualization', 1);


% detect KAZE features (bulbs) from the image. 
% These features turns out to be the only ones we cares about. 
% In another word, this will ignore the lines of the music sheet. 
boxPoints = detectKAZEFeatures(I1);
scenePoints = detectKAZEFeatures(I2);

% extract HOG feature around the points
[boxVectors,validBoxPoints,boxptsVis] = extractHOGFeatures(I1,...
    selectStrongest(boxPoints,floor(length(boxPoints)*0.15)),'CellSize',[4 4]);
[sceneVectors,validScenePoints, sceneptsVis] = extractHOGFeatures(I2,...
    selectStrongest(scenePoints,floor(length(scenePoints)*0.15)),'CellSize',[4 4]);


% Visualize the HOG features around the points
HOGVisualization(I1, boxptsVis, 'I1 strongest 10 HOG points', 0)
HOGVisualization(I2, sceneptsVis, 'I2 Important HOG points', 0)


% match Features of two Picures and Visualize them
Pairs = matchFeatures(boxVectors, sceneVectors,'MatchThreshold',80,...
'Method','Approximate');

matchedOriginal  = validBoxPoints(Pairs(:,1));
matchedDistorted = validScenePoints(Pairs(:,2));

figure
showMatchedFeatures(I1, I2, matchedOriginal, matchedDistorted, 'montage')
title('Candidate matched points (including outliers)')
