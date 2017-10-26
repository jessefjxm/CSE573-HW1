function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

% param & init
K = 300;
alpha = 200;
filterBank  = createFilterBank();
res = zeros(length(imPaths)*alpha, length(filterBank)*3);

% load image
for i = 0:length(imPaths)-1
    img = imread(imPaths{i+1});
    [filter_response] = extractFilterResponses(img, filterBank);
    trans_response = reshape(filter_response,size(filter_response,1)*size(filter_response,2),size(filter_response,3));
    
    % get random pixels
    N = numel(img(:,:,1));
    pixels = randperm(N, alpha)';
    res(i*alpha+1: (i+1)*alpha,:) = trans_response(pixels,:);
end
% kmeans cluster
[~, dictionary] = kmeans(res, K, 'EmptyAction', 'drop');
% change to column wise
dictionary = dictionary';
end
