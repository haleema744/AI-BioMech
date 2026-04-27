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

    batchCount = size(batchFeatures,1);
    featuresSynthetic(idx:idx+batchCount-1,:) = batchFeatures;

    idx = idx + batchCount;
end

%% -------------------- 7. Compute Euclidean Distances ----------------
fprintf('Computing Euclidean distances...\n');

numReal = size(featuresReal,1);
topK = 5;  % closest synthetic images

topIndices = zeros(numReal, topK);
topDistances = zeros(numReal, topK);

for i = 1:numReal
    % Euclidean distance between real image i and all synthetic images
    diff = featuresSynthetic - featuresReal(i,:);
    distances = sqrt(sum(diff.^2, 2));

    % Find topK closest synthetic images
    [topDistances(i,:), topIndices(i,:)] = mink(distances, topK);
end

%% -------------------- 8. Display Example ---------------------
fprintf('\nTop-%d closest synthetic images for first real image (Euclidean distance):\n', topK);
disp('Synthetic image indices:');
disp(topIndices(1,:));
disp('Distances:');
disp(topDistances(1,:));

%% -------------------- 9. Compute Total (Average) Distance ---------
totalDistance = 0;

for i = 1:numReal
    diff = featuresSynthetic - featuresReal(i,:);
    distances = sqrt(sum(diff.^2, 2));
    totalDistance = totalDistance + mean(distances);
end

totalDistance = totalDistance / numReal;
totalCount = numReal * numSynthetic;

fprintf('\n====================================\n');
fprintf('TOTAL AVERAGE EUCLIDEAN DISTANCE = %.6f\n', totalDistance);
fprintf('TOTAL PAIR COUNT = %d\n', totalCount);
fprintf('====================================\n');

%% -------------------- 10. Save Results -------------------------
save('resnet101_euclidean_distance.mat', ...
    'topIndices', 'topDistances', 'featureLayer', '-v7.3');

fprintf('PROCESS COMPLETED SUCCESSFULLY\n');