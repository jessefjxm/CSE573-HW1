function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs:
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses

% check if it's grayscale
if(size(img,3) == 1)
    img = repmat(img, [1 1 3]);
end

% convert to W x H x N*3 matrix
dImg = double(img);
[L,a,b] = RGB2Lab(dImg(:,:,1), dImg(:,:,2), dImg(:,:,3));

% transfer
filterResponses = zeros(size(dImg,1), size(dImg,2), length(filterBank)*3);
for i = 0:length(filterBank)-1
    filter = filterBank{i+1};
    filterResponses(:,:,i*3+1) = reshape(imfilter(L, filter), size(dImg,1), size(dImg,2));
    filterResponses(:,:,i*3+2) = reshape(imfilter(a, filter), size(dImg,1), size(dImg,2));
    filterResponses(:,:,i*3+3) = reshape(imfilter(b, filter), size(dImg,1), size(dImg,2));
end

end
