
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
numClasses = 2;
encoderDepth = 3;
lgraph = unetLayers(inputSize,numClasses,'EncoderDepth',encoderDepth);

initialLearningRate = 0.05;
maxEpochs = 10;
minibatchSize = 32;
l2reg = 0.0001;

options = trainingOptions('sgdm',...
    'ExecutionEnvironment', 'gpu',...
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

red = trainNetwork(dsTrain,lgraph,options);

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


