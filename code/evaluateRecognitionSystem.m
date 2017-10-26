function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

load('vision.mat');
load('../data/traintest.mat');
src = '../data/';

C = zeros(length(mapping));
for k = 1:length(test_labels)
    i = test_labels(k);
    guess = guessImage([src, test_imagenames{k}]);
    index = strfind(mapping, guess);    
    j = find(not(cellfun('isempty', index)));
    C(i,j) = C(i,j) + 1;
    if(i ~= j)
        fprintf('Bad predict: %s%\n',test_imagenames{k});
    end        
end

C
fprintf('Prediction Accruacy: %d%',trace(C) / sum(C(:)) * 100);

end