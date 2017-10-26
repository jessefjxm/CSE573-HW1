myVars = {'filterBank','dictionary'};
S = load('dictionary.mat', myVars{:});
img = imread('../sample3.jpg');
[wordMap] = getVisualWords(img, S.filterBank, S.dictionary);
imagesc(wordMap)
batchToVisualWords(4);