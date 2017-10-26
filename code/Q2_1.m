myVars = {'filterBank','dictionary'};
S = load('dictionary.mat', myVars{:});
img = imread('../sample.jpg');
[wordMap] = getVisualWords(img, S.filterBank, S.dictionary);
h = getImageFeatures(wordMap, 200);
stairs(h)