% this is a helper function to visualize HOG feature
% if ind = 0; then the image and points will be on the same one
% if ind = 1, then the image and points will be on seperate figure 

function HOGVisualization(Image, pts, name, ind)

figure;

if ind == 0
    imshow(Image);
    hold on;
elseif ind == 1
    subplot(1,2,1);
    imshow(Image);
    subplot(1,2,2);
end

plot(pts,'Color','green');
title(name);
end
