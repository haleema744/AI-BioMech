%% ResNet-101 Feature Extraction + Cosine Similarity
% Synthetic dataset: ~350,000 images
% Real dataset: ~200 images
clc;
clear;
close all;

%% -------------------- 1. Load ResNet-101 --------------------
net = resnet101;

% Correct layer name for MATLAB ResNet-101
featureLayer = 'pool5';   % 2048-D features

inputSize = net.Layers(1).InputSize;

%% -------------------- 2. Dataset Paths ----------------------
syntheticDir = 'path_to_synthetic_dataset';   % <-- CHANGE
realDir      = 'path_to_real_dataset';        % <-- CHANGE

%% -------------------- 3. Load ImageDatastores ----------------
imdsSynthetic = imageDatastore(syntheticDir, ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');

imdsReal = imageDatastore(realDir, ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');

fprintf('Synthetic images: %d\n', numel(imdsSynthetic.Files));
fprintf('Real images: %d\n', numel(imdsReal.Files));

%% -------------------- 4. Augmented Datastores ----------------
augSynthetic = augmentedImageDatastore(inputSize(1:2), imdsSynthetic, ...
    'ColorPreprocessing', 'gray2rgb');

augReal = augmentedImageDatastore(inputSize(1:2), imdsReal, ...
    'ColorPreprocessing', 'gray2rgb');

%% -------------------- 5. Extract Real Features ----------------
fprintf('Extracting real image features...\n');

featuresReal = activations(net, augReal, featureLayer, ...
    'OutputAs', 'rows');

% Explicit L2 normalization (CRITICAL)
featuresReal = featuresReal ./ sqrt(sum(featuresReal.^2, 2));

featureDim = size(featuresReal, 2);

%% -------------------- 6. Extract Synthetic Features (Batch) ---
fprintf('Extracting synthetic image features...\n');

numSynthetic = numel(imdsSynthetic.Files);
featuresSynthetic = zeros(numSynthetic, featureDim, 'single');

reset(augSynthetic);
idx = 1;

while hasdata(augSynthetic)
    dataBatch = read(augSynthetic);

    batchFeatures = activations(net, dataBatch, featureLayer, ...
        'OutputAs', 'rows');

    % L2 normalize batch
    batchFeatures = batchFeatures ./ ...
        sqrt(sum(batchFeatures.^2, 2));

    batchCount = size(batchFeatures,1);
    featuresSynthetic(idx:idx+batchCount-1,:) = batchFeatures;

    idx = idx + batchCount;
end

%% -------------------- 7. Sanity Check ------------------------
fprintf('Checking feature norms...\n');
fprintf('Max synthetic norm: %.4f\n', max(vecnorm(featuresSynthetic,2,2)));
fprintf('Max real norm: %.4f\n', max(vecnorm(featuresReal,2,2)));

%% -------------------- 8. Cosine Similarity -------------------
fprintf('Computing cosine similarity...\n');

numReal = size(featuresReal,1);
topK = 5;

topIndices = zeros(numReal, topK);
topScores  = zeros(numReal, topK);

for i = 1:numReal
    similarity = featuresSynthetic * featuresReal(i,:)';
    [topScores(i,:), topIndices(i,:)] = maxk(similarity, topK);
end

%% -------------------- 9. Display Example ---------------------
fprintf('\nTop-%d synthetic matches for first real image:\n', topK);

disp('Synthetic image indices:');
disp(topIndices(1,:));

disp('Cosine similarity scores:');
disp(topScores(1,:));

%% -------------------- 10. Retrieve Image Names ----------------
fprintf('\nMatched synthetic image files:\n');
disp(imdsSynthetic.Files(topIndices(1,:)));

%% -------------------- 11. Save Results -----------------------
save('resnet101_cosine_similarity.mat', ...
    'topIndices', 'topScores', ...
    'featureLayer', '-v7.3');

fprintf('\nPROCESS COMPLETED SUCCESSFULLY\n');
%% -------------------- 12. TOTAL SIMILARITY --------------------
fprintf('\nComputing average similarity...\n');

numReal = size(featuresReal,1);
totalSimilarity = 0;

for i = 1:numReal
    sim = featuresSynthetic * featuresReal(i,:)';
    totalSimilarity = totalSimilarity + mean(sim);
end

totalSimilarity = totalSimilarity / numReal;

fprintf('\n====================================\n');
fprintf('Average COSINE SIMILARITY = %.6f\n', totalSimilarity);
fprintf('====================================\n');
%% -------------------- 12. TOTAL SIMILARITY & COUNT --------------------
fprintf('\nComputing TOTAL similarity count...\n');

numReal = size(featuresReal,1);
numSynthetic = size(featuresSynthetic,1);

totalSimilarity = 0;

for i = 1:numReal
    sim = featuresSynthetic * featuresReal(i,:)';
    totalSimilarity = totalSimilarity + mean(sim);
end

totalSimilarity = totalSimilarity / numReal;

totalCount = numReal * numSynthetic;

fprintf('\n====================================\n');
fprintf('TOTAL COSINE SIMILARITY = %.6f\n', totalSimilarity);
fprintf('TOTAL SIMILARITY COUNT = %d\n', totalCount);
fprintf('====================================\n');