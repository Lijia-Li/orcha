trainingData = imageSet('MLData/Training','recursive');
testingData = imageSet('MLData/Testing','recursive');
I = read(trainingData(4),2);
% imshow(I)

% Prepare Training Image Sets
minSetCount = min([trainingData.Count]);
trainingSets = partition(trainingData, minSetCount, 'randomize');
[trainingSets.Count]

% Create a Visual Vocabulary from Training Data
bag = bagOfFeatures(trainingSets, 'VocabularySize',100,'PointSelection','Detector');

% % Display Visual Word Occurrence Histograms
% img = read(trainingData(1),randi(trainingData(1).Count));
% featureVector = encode(bag, img);
% figure
% subplot(3,2,1);imshow(img);
% subplot(3,2,2);
% bar(featureVector);title('Visual Word Occurrences');
% xlabel('Visual Word Index');
% ylabel('Frequency of occurence');
% 
% img = read(trainingData(2),randi(trainingData(2).Count));
% featureVector = encode(bag, img);
% figure
% subplot(3,2,1);imshow(img);
% subplot(3,2,2);
% bar(featureVector);title('Visual Word Occurrences');
% xlabel('Visual Word Index');
% ylabel('Frequency of occurence');
% 
% img = read(trainingData(3),randi(trainingData(3).Count));
% featureVector = encode(bag, img);
% figure
% subplot(3,2,1);imshow(img);
% subplot(3,2,2);
% bar(featureVector);title('Visual Word Occurrences');
% xlabel('Visual Word Index');
% ylabel('Frequency of occurence');

% Train a classifier to discriminate between categories
categoryClassifier = trainImageCategoryClassifier(trainingData, bag);

% Evaluate Classifier Performance on Testing Set
confMatrix = evaluate(categoryClassifier, testingData);