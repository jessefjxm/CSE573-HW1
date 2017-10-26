function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.
load('dictionary.mat');
load('../data/traintest.mat');
src = '../data/';

% load images
L = 3;
K = length(dictionary);
trainSize = length(train_imagenames);
train_features = zeros(K*(4^L-1)/3, trainSize);

for i=1:trainSize
    load([src, strrep(train_imagenames{i}, '.jpg', '.mat')]);
    train_features(:, i) = getImageFeaturesSPM(L, wordMap, K);
end

save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end