function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

wordMap = zeros(size(img,1)*size(img,2), 1);
[filter_response] = extractFilterResponses(img, filterBank);
trans_response = reshape(filter_response,size(filter_response,1)*size(filter_response,2),size(filter_response,3));
    
dist = pdist2(dictionary', trans_response);
mindist = min(dist);

for i = 1:length(mindist)
    wordMap(i) = find(dist(:,i) == mindist(i));
end
wordMap = reshape(wordMap, size(img,1), size(img,2));

end
