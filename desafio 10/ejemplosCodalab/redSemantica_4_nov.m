
imds=imageDatastore('nimages','FileExtensions','.jpg');
I = readimage(imds,1);
figure
imshow(I)
pxDir='nmask';

classNames = ["fondo" "carretera"];
pixelLabelID = [0 255];
pxds = pixelLabelDatastore(pxDir,classNames,pixelLabelID);
C = readimage(pxds,1);
sum(sum(C==classNames(2)))

% creando la estructura
inputSize = [64 64 3];
imgLayer = imageInputLayer(inputSize)

filterSize = 3;
numFilters = 32;
conv = convolution2dLayer(filterSize,numFilters,'Padding',1);
relu = reluLayer();
poolSize = 2;
maxPoolDownsample2x = maxPooling2dLayer(poolSize,'Stride',2);

downsamplingLayers = [
    conv
    relu
    maxPoolDownsample2x
    conv
    relu
    maxPoolDownsample2x
    ]

filterSize = 4;
transposedConvUpsample2x = transposedConv2dLayer(4,numFilters,'Stride',2,'Cropping',1);

upsamplingLayers = [
    transposedConvUpsample2x
    relu
    transposedConvUpsample2x
    relu
    ]

numClasses = 2;
conv1x1 = convolution2dLayer(1,numClasses);

finalLayers = [
    conv1x1
    softmaxLayer()
    pixelClassificationLayer()
    ]
net = [
    imgLayer    
    downsamplingLayers
    upsamplingLayers
    finalLayers
    ]



initialLearningRate = 0.05;
maxEpochs = 20;
minibatchSize = 160;
l2reg = 0.0001;

options = trainingOptions('sgdm',...
    'InitialLearnRate',initialLearningRate, ...
    'Momentum',0.9,...
    'L2Regularization',l2reg,...
    'MaxEpochs',maxEpochs,...
    'MiniBatchSize',minibatchSize,...
    'LearnRateSchedule','piecewise',... 
    'Shuffle','every-epoch',...
    'GradientThresholdMethod','l2norm',...
    'GradientThreshold',0.05, ...
    'Plots','training-progress', ...
    'Verbose',0);

dsTrain = randomPatchExtractionDatastore(imds,pxds,[64,64],'PatchesPerImage',16000);

red = trainNetwork(dsTrain,net,options);

% evaluar
for kk=1:16
    figure;
I = readimage(imds,kk);
subplot(1,3,1)
imshow(I)
C = readimage(pxds,kk);
mask=zeros(size(C));
mask(C==classNames(2))=1;
subplot(1,3,2)
imshow(mask)

segmentada = semanticseg(I,red, 'outputtype', 'uint8');
subplot(1,3,3)
 imshow(double(segmentada-1))

end


