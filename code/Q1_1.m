[filterBank] = createFilterBank();
img = imread('../sample.jpg');
[filter_response] = extractFilterResponses(img, filterBank);
images = reshape(filter_response, size(img,1), size(img,2), 3, length(filterBank));
montage(images);