function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

% init
h = zeros(dictionarySize * (4 ^ (layerNum) - 1)/3, 1);
L = layerNum - 1;
layerSize = 2^L;
row = floor(size(wordMap,1) / layerSize);
col = floor(size(wordMap,2) / layerSize);

% first, do finest layer
curSize = 0;
for i = 1:layerSize
    for j = 1:layerSize
        cells = wordMap(1+(i-1)*row:i*row, 1+(j-1)*col:j*col);
        num = (i-1)*(2^L) + j;
        h(dictionarySize*(num-1)+1: dictionarySize*num, 1) = getImageFeatures(cells, dictionarySize) .* 0.5;
    end
end

% second, do other layers
index = 0;
for i = 1:L
    layer = L - i;
    if layer == 0
        weight = 2^(layer-L);
    else
        weight = 2^(layer-L-1);
    end
    
    layerSize = 2^layer;
    for j = 1:layerSize
        for k = 1:layerSize
            % map sub cells to corresponding coords
            C1 = dictionarySize*(4*(j-1)*layerSize + 2*(k-1))+index;
            H1 = h(C1+1:C1+dictionarySize);
            C2 = C1+2*layerSize*dictionarySize;
            H2 = h(C2+1:C2+dictionarySize);
            C3 = C1+1*dictionarySize;
            H3 = h(C3+1:C3+dictionarySize);
            C4 = C2+1*dictionarySize;
            H4 = h(C4+1:C4+dictionarySize);
            
            % sum up sub-histograms
            h(curSize+1:curSize+dictionarySize) = (H1+H2+H3+H4) .* weight;
            curSize = curSize + dictionarySize;
        end
    end    
    index = index + dictionarySize*(2^(layer+1))^2;
end

% normalize result
h = h / norm(h,1);

end