% Read snippet image
boxImage = rgb2gray(imread('orchaSearch/Snippet/melody_snippet.jpeg'));
figure;
imshow(boxImage);
title('Image of a melody snippet');

% Read full scene image
sceneImage = rgb2gray(imread('orchaSearch/Scene/melody_scene.jpeg'));
figure; 
imshow(sceneImage);
title('Image of a complete melody');

% Detect feature points in both images.
boxPoints = detectSURFFeatures(boxImage,'NumScaleLevels',4);
scenePoints = detectSURFFeatures(sceneImage);

% Visualize the strongest feature points found in the reference image.
figure; 
imshow(boxImage);
title('100 Strongest Feature Points from Box Image');
hold on;
plot(selectStrongest(boxPoints, 100));

% Visualize the strongest feature points found in the target image.
figure; 
imshow(sceneImage);
title('200 Strongest Feature Points from Scene Image');
hold on;
plot(selectStrongest(scenePoints, 200));

% Extract feature descriptors at the interest points in both images.
[boxFeatures, boxPoints] = extractFeatures(boxImage, boxPoints,'method','kaze');
[sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints,'method','kaze');

% Match the features using their descriptors. 
boxPairs = matchFeatures(boxFeatures, sceneFeatures,'MatchThreshold',8,'Method','Approximate');

% Display putatively matched features. 
matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
matchedScenePoints = scenePoints(boxPairs(:, 2), :);
figure;
showMatchedFeatures(boxImage, sceneImage, matchedBoxPoints, ...
    matchedScenePoints, 'montage');
title('Putatively Matched Points (Including Outliers)');