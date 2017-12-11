% Create empty array to track the amount of pairs between snippets and
% scene images.
pairList = [];

% Read snippet image
snipImage = rgb2gray(imread('orchaSearch/Snippet/elice_snippet.png'));
figure;
imshow(snipImage);
title('Image of a melody snippet target');

boxPoints = detectSURFFeatures(snipImage,'NumScaleLevels',4);

% Visualize the strongest feature points found in the reference snipImage.
figure; 
imshow(snipImage);
title('100 Strongest Feature Points from Box Image');
hold on;
plot(selectStrongest(boxPoints, 100));

% Scene image is the complete music sheet in image formats.
% Read full scene image one by on in a directory folder. Return a list of
% file names and their directory address. The sceneImage then reads every
% single scene images.
 
dinfo = dir('orchaSearch/Scene');
names_cell = {dinfo.name};
names_cell(:,1:2) = [];
imageAddress = strcat('orchaSearch/Scene', '/', names_cell);
[~, sceneSize] = size(imageAddress);


% Read every scene image and detect its features.
for i = 1:sceneSize
    % Read scene image and turn it into grey scale.
    sceneImage = rgb2gray(imread(char(imageAddress(i))));

    % Detect feature points in scene images.
    scenePoints = detectSURFFeatures(sceneImage);
 
%     % Visualize the strongest feature points found in the target image.
%     figure; 
%     imshow(sceneImage);
%     title('200 Strongest Feature Points from Scene Image');
%     hold on;
%     plot(selectStrongest(scenePoints, 200));

    % Extract feature descriptors at the interest points in both images.
    [boxFeatures, boxPoints] = extractFeatures(snipImage, boxPoints,'method','kaze');
    [sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints,'method','kaze');
    % [boxFeatures, boxPoints] = extractFeatures(snipImage, boxPoints,'method','kaze');
    % [sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints,'method','kaze');


    % Match the features using their descriptors. 
    boxPairs = matchFeatures(boxFeatures, sceneFeatures,'MatchThreshold',8,'Method','Approximate');
    numPairs = size(boxPairs,1);
    pairList = [pairList;numPairs];

    % Display putatively matched features. 
    matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
    matchedScenePoints = scenePoints(boxPairs(:, 2), :);
    figure;
    showMatchedFeatures(snipImage, sceneImage, matchedBoxPoints, ...
        matchedScenePoints, 'montage');
    title('Matched Points (Including Outliers)');
end

[maxMatch, maxIdx] = max(pairList);
possibleMatchName = names_cell(maxIdx);
disp('Based on our search in our database, your snnippet most likely comes from: ');
disp(possibleMatchName);
disp('Total match points (including outliers:');
disp(maxMatch);
