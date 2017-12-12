% Create empty array to track the amount of pairs between snippets and
% scene images.
pairList = [];

% Read snippet image
snipImage = rgb2gray(imread(char(snip)));
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
names_cell(:,1:3) = [];
imageAddress = strcat('orchaSearch/Scene', '/', names_cell);
[~, sceneSize] = size(imageAddress);

% Extract feature descriptors at the interest points in both images.
[boxFeatures, boxPoints] = extractFeatures(snipImage, boxPoints,'method','kaze');

% Read every scene image, detect its features, and store the number of matchpoints.
for i = 1:sceneSize
    % Read scene image and turn it into grey scale.
    sceneImage = rgb2gray(imread(char(imageAddress(i))));

    % Detect feature points in scene images.
    scenePoints = detectKAZEFeatures(sceneImage);
 
%     % Visualize the strongest feature points found in the target image.
%     figure; 
%     imshow(sceneImage);
%     title('200 Strongest Feature Points from Scene Image');
%     hold on;
%     plot(selectStrongest(scenePoints, 200));

    % Extract feature descriptors at the interest points in both images.
    [sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints,'method','kaze');
    
     % Match the features using their descriptors. 
    boxPairs = matchFeatures(boxFeatures, sceneFeatures,'MatchThreshold',8,'Method','Approximate');
    numPairs = size(boxPairs,1);
    pairList = [pairList;numPairs];

    % Display putatively matched features, including outliers. 
    matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
    matchedScenePoints = scenePoints(boxPairs(:, 2), :);
    
    % Display Results in a window.
    figure;
    showMatchedFeatures(snipImage, sceneImage, matchedBoxPoints, matchedScenePoints, 'montage');
    title('Matched Points (Including Outliers)');
    str_title = strcat('Searched image occurance in:  ', names_cell(i));
    str_numPairs = strcat('Numbers of matched pairs discovered:  ', num2str(numPairs(1,1)));
    text(50,30,str_title,'Color','white','FontSize',18);
    text(50,60,str_numPairs,'Color','white','FontSize',18);
    
    % Is there a possible match?
    if numPairs(1,1) ~= 0
        text(50,90,'POSSIBLE MATCH','Color','green','FontSize',18);
    else
        text(50,90,'NO MATCH','Color','red','FontSize',18);
    end
end

% Return the name and index of top three scene matched.
[temp,originalpos] = sort( pairList, 'descend' );
n = temp(1:3);
matchedIdx=originalpos(1:3);
[maxMatch, ~] = max(pairList);

% Print out the results.
disp('Based on our search in our database, your snnippet most likely comes from: ');
disp(names_cell(matchedIdx(1,1)));
disp(names_cell(matchedIdx(2,1)));
disp(names_cell(matchedIdx(3,1)));
disp('The highest number of match points (including outliers:');
disp(maxMatch);