% this function will test on cell size of 2,4,8 and return a figure with
% HOG visualization as it's output

function HOGCellSizeTest(image)

% Extract HOG features and HOG visualization
[hog_2x2, vis2x2] = extractHOGFeatures(image,'CellSize',[2 2]);
[hog_4x4, vis4x4] = extractHOGFeatures(image,'CellSize',[4 4]);
[hog_8x8, vis8x8] = extractHOGFeatures(image,'CellSize',[8 8]);

% Show the original image
figure;
title('HOG Cell Size Test')
subplot(2,3,1:3); imshow(image);

% Visualize the HOG features
subplot(2,3,4);
plot(vis2x2);
title({'CellSize = [2 2]'; ['Length = ' num2str(length(hog_2x2))]});

subplot(2,3,5);
plot(vis4x4);
title({'CellSize = [4 4]'; ['Length = ' num2str(length(hog_4x4))]});

subplot(2,3,6);
plot(vis8x8);
title({'CellSize = [8 8]'; ['Length = ' num2str(length(hog_8x8))]});

end


