clc
close all
clear all
labelDir=fullfile('C:\Users\s2278791\Desktop\LABEL');
imgDir=fullfile('C:\Users\s2278791\Desktop\INPUT');
imds=imageDatastore(imgDir);
imagesize=[224 224 3];
% Resize images on-the-fly
imds = augmentedImageDatastore(imagesize, imds);


classes = ["class" + string(0:64)];
%classes = ["class0", "class1","class2","class3","class4","class5","class6","class7","class8","class9","class10","class11","class12"];
labelsIDs = {
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
pxds=pixelLabelDatastore(labelDir,classes,labelsIDs);
tbl = countEachLabel(pxds);


[imdsTrain, imdsVal, imdsTest, pxdsTrain, pxdsVal, PxdsTest]=partitionData(imds,pxds)

numClasses=65;
lgraph = deeplabv3plusLayers(imagesize, 65, 'resnet50');

% Find the layer names to be unfrozen
layerNames = arrayfun(@(layer) layer.Name, lgraph.Layers, 'UniformOutput', false);
learnableLayerIndices = find(arrayfun(@(layer) isprop(layer,'Weights') && ~isempty(layer.Weights), lgraph.Layers));
% Find the layer names to be unfrozen
layerNames = arrayfun(@(layer) layer.Name, lgraph.Layers, 'UniformOutput', false);
learnableLayerIndices = find(arrayfun(@(layer) isprop(layer,'Weights') && ~isempty(layer.Weights), lgraph.Layers));
net=lgraph();
analyzeNetwork(net);
imageFreq=tbl.PixelCount./tbl.ImagePixelCount;
%classweight=median(imageFreq)./imageFreq;
pxLayer=pixelClassificationLayer('Name','label','Classes',tbl.Name);%'ClassWeights',classweight);
lgraph=replaceLayer(lgraph,'classification',pxLayer);

pximdsval=pixelLabelImageDatastore(imdsVal,pxdsVal);
options=trainingOptions('sgdm',...
    'LearnRateSchedule','piecewise',...
    'LearnRateDropPeriod', 5,...
    'LearnRateDropFactor',0.3,...
    'Momentum',0.9,...
    'InitialLearnRate',0.001,...
    'L2Regularization',0.005,...
    'ValidationData',pximdsval,...
    'MaxEpochs',100,...
    'MiniBatchSize',32,...
    'Shuffle','every-epoch',... ...
    'CheckpointPath', tempdir,...
    'VerboseFrequency',2,...
    'Plots','training-progress','ValidationPatience',4);
augmenter=imageDataAugmenter('RandXReflection',true,...
    'RandXTranslation',[-10 10], 'RandYTranslation',[-10 10]);
pximds=pixelLabelImageDatastore(imdsTrain,pxdsTrain);
Input_Layer_Size=net.Layers(1).InputSize(1:2);
%pximds=augmentedImageDatastore(Input_Layer_Size,pximds);
augimds = augmentedImageDatastore(Input_Layer_Size, imdsTrain);
    [snetHS_X, info]=trainNetwork(pximds,lgraph,options)
save snetHS_X
I=imread('C:\Users\s2278791\Desktop\11.png');
%I=readimage(imdsTest,137);
I=imresize(I, [224 224])
c=semanticseg(I,snetHS_X)
c=imresize(c, [224 224])
% cmap=[255 255 255
%     0  0 170
%  0 0 255
%  0 85 255
%  0 170 255
%  0 255 255
%  85 255 170
%  170 255 85
%  255 255 0
%  255 170 0
%  255 85 0
%  255 0 0
%  170 0 0]
% cmap=cmap./255;
colorbar
B=labeloverlay(I,c,'Colormap',jet,'Transparency',0.1);
grayOriginal = im2gray(I);

% Create a mask for the white background (assuming white is 255 in grayscale)
whiteMask = grayOriginal == 255;

% Create a mask for the black regions (assuming black is 0 in grayscale)
blackMask = grayOriginal == 0;

% Initialize the cleaned segmented image with the segmented overlay image
cleanSegmentedImage = B;

% Set overlay color on the white background to white in the cleaned image
cleanSegmentedImage(repmat(whiteMask, [1, 1, 3])) = 255;


% Display the original, segmented, and cleaned segmented images
subplot(1,2,1)
imshow(I);
title('Original Image')

subplot(1,2,2)
imshow(cleanSegmentedImage);
title('AI-Generated');
%imshow(B)


 