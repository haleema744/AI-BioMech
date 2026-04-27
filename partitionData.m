function [imdsTrain,imdsVal,imdsTest,pxdsTrain,pxdsVal,pxdsTest] = partitionData(imds,pxds)
    rng(0);  % For reproducibility
    numFiles = numel(imds.Files);
    shuffledIndices = randperm(numFiles);

    % Split fractions
    numTrain = round(0.6 * numFiles);
    numVal   = round(0.2 * numFiles);
    % Remaining for test
    trainingIdx = shuffledIndices(1:numTrain);
    valIdx      = shuffledIndices(numTrain+1 : numTrain+numVal);
    testIdx     = shuffledIndices(numTrain+numVal+1 : end);

    % Split images
    imdsTrain = imageDatastore(imds.Files(trainingIdx));
    imdsVal   = imageDatastore(imds.Files(valIdx));
    imdsTest  = imageDatastore(imds.Files(testIdx));

    % Define label classes and IDs manually (example)
    classes = pxds.ClassNames;
    PixelLabelID = {
    [255 255 255];
    [0,0,143];
 [0,0,159];
 [0,0,175];
 [0,0,191];
 [0,0,207];
 [0,0,223];
 [0,0,239];
 [0,0,255];
 [0,16,255];
 [0,32,255];
 [0,48,255];
 [0,64,255];
 [0,80,255];
 [0,96,255];
 [0,112,255];
 [0,128,255];
 [0,143,255];
 [0,159,255];
 [0,175,255];
 [0,191,255];
 [0,207,255];
 [0,223,255];
 [0,239,255];
 [0,255,255];
 [16,255,239];
 [32,255,223];
 [48,255,207];
 [64,255,191];
 [80,255,175];
 [96,255,159];
 [112,255,143];
 [128,255,128];
 [143,255,112];
 [159,255,96];
 [175,255,80];
 [191,255,64];
 [207,255,48];
 [223,255,32];
 [239,255,16];
 [255,255,0];
 [255,239,0];
 [255,223,0];
 [255,207,0];
 [255,191,0];
 [255,175,0];
 [255,159,0];
 [255,143,0];
 [255,128,0];
 [255,112,0];
 [255,96,0];
 [255,80,0];
 [255,64,0];
 [255,48,0];
 [255,32,0];
 [255,16,0];
 [255,0,0];
 [239,0,0];
 [223,0,0];
 [207,0,0];
 [191,0,0];
 [175,0,0];
 [159,0,0];
 [143,0,0];
 [128,0,0];
};
% Split label files
    pxdsTrain = pixelLabelDatastore(pxds.Files(trainingIdx), classes, PixelLabelID);
    pxdsVal   = pixelLabelDatastore(pxds.Files(valIdx), classes, PixelLabelID);
    pxdsTest  = pixelLabelDatastore(pxds.Files(testIdx), classes, PixelLabelID);
end